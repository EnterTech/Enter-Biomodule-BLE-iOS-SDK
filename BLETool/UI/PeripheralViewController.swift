//
//  PeripheralViewController.swift
//  FlowTimeBLE
//
//  Created by NyanCat on 26/10/2017.
//  Copyright © 2017 EnterTech. All rights reserved.
//

import UIKit
import CoreBluetooth
import RxBluetoothKit
import RxSwift
import SVProgressHUD
import FlowTimeBLE
import PromiseKit

class PeripheralViewController: UITableViewController {

    var peripheral: Peripheral!
    var services: [BLEService] = []
    var characteristics: [CBUUID: [RxBluetoothKit.Characteristic]] = [:]

    let disposeBag: DisposeBag = DisposeBag()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
    }

    deinit {
        connector.cancel()
    }

    var connector: Connector!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = peripheral.displayName

        tableView.tableFooterView = UIView()

        SVProgressHUD.show(withStatus: "Connecting:\n \(peripheral.displayName)")

        connector = Connector(peripheral: peripheral)
        firstly {
            connector.tryConnect()
            }.done {
                SVProgressHUD.showSuccess(withStatus: "connect succeeded")
                dispatch_to_main {
                    self.services = self.connector.allServices
                    self.tableView.reloadData()
                }
            }
            .catch { _ in
                SVProgressHUD.showError(withStatus: "Connect failed!")
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "serviceCellIdentifier", for: indexPath)
        let service = self.services[indexPath.row]
        cell.textLabel?.text = service.displayName
        cell.detailTextLabel?.text = service.uuid
        return cell
    }

    private var _selectedService: BLEService?

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        _selectedService = self.services[indexPath.row]

        switch type(of: _selectedService!)  {
        case is ConnectService.Type, is BatteryService.Type, is DeviceInfoService.Type, is CommandService.Type:
            self.performSegue(withIdentifier: "pushToCharacteristic", sender: self)
            break
//        case is CommandService.Type:
//            self.performSegue(withIdentifier: "pushToCommand", sender: self)
//            break
        case is EEGService.Type:
            self.performSegue(withIdentifier: "pushToEEG", sender: self)
            break
        case is DFUService.Type:
            self.performSegue(withIdentifier: "DFUIdentifier", sender: self)
            break;
        default:
            break
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CharacteristicViewController {
            vc.service = _selectedService
        }
//        if let vc = segue.destination as? CommandViewController,
//            let service = _selectedService as? CommandService {
//            vc.service = service
//        }
        if let vc = segue.destination as? CommandModeViewController {
            vc.eegService = connector.eegService
            vc.commandService = connector.commandService
            vc.heartService = connector.heartService
            vc.peripheral = peripheral
        }

        if let vc = segue.destination as? DFUViewController {
            vc.peripheral = self.peripheral.peripheral
            vc.cManager = self.peripheral.manager.centralManager
        }
    }
}
