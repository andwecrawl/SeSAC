//
//  BackupViewController.swift
//  PhotoGramRealm
//
//  Created by yeoni on 2023/09/07.
//

import UIKit
import Zip

class BackupViewController: BaseViewController {
    
    let backupButton = {
        let view = UIButton()
        view.backgroundColor = .systemYellow
        return view
    }()
    
    let restoreButton = {
        let view = UIButton()
        view.backgroundColor = .systemGreen
        return view
    }()
    
    let backupTableView = {
        let view = UITableView()
        view.rowHeight = 50
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    override func configure() {
        super.configure()
        
        view.addSubview(backupTableView)
        view.addSubview(backupButton)
        view.addSubview(restoreButton)
        
        backupButton.addTarget(self, action: #selector(backupButtonTapped), for: .touchUpInside)
        restoreButton.addTarget(self, action: #selector(restoreButtonTapped), for: .touchUpInside)
        backupTableView.delegate = self
        backupTableView.dataSource = self
    }
    
    @objc func backupButtonTapped() {
        // 우리는 이미지도 압축해 주어야 하고 realm 파일도 압축해야 함
        // 1. 백업하고자 하는 파일의 경로를 담은 배열을 생성
        var urlPaths = [URL]()
        
        // 2. 도큐먼트 위치 가져오기
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "도큐먼트 위치에 오류가 있어요!")
            return
        }
        
        // 3. 백업하고자 하는 파일의 경로
        // ex) ~~~/~~/~~~/Document/default.realm
        let realmFile = path.appendingPathComponent("default.realm")
        
        // 우리는 위 경로 안에 파일이 있는지 우리는 확신할 수 없음
        // => 따라서, 파일 매니저에게 물어봐서 경로가 유효한지 확인해야 함!!
        
        //4. 3번 경로가 유효한지 확인
        guard FileManager.default.fileExists(atPath: realmFile.path) else {
            showAlertMessage(title: "백업할 파일이 없습니다")
            return
        }
        
        // 5. 압축하고자 하는 파일을 배열에 추가
        urlPaths.append(realmFile)
        
        // 6. 이 배열을 통으로 압축하면 파일들이 압축될 거임
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "yeoniArchive")
            print("location: \(zipFilePath)")
        } catch {
            showAlertMessage(title: "압축을 실패했어요!")
        }
    }
    
    @objc func restoreButtonTapped() {
        
        // 파일 앱을 통한 복구 진행!!
        // 모두 접근할 수 있도록 만들면 분기 처리할 게 너무 많을 거임!!
        // 원하는 파일만 가져오도록~~!!
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        // copy? => data는 document에 냅두고 데이터를 복사해서 가져올게~~
        present(documentPicker, animated: true)
        
        
    }
    
    
    override func setConstraints() {
        super.setConstraints()
        backupTableView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
        }
        
        backupButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.top.leading.equalTo(view.safeAreaLayoutGuide)
        }
        
        restoreButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
}


extension BackupViewController: UIDocumentPickerDelegate {
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(#function, urls)
        guard let selectedFileURL = urls.first else {
            print("선택한 파일에 오류가 있어요!")
            return
        }
        
        guard let path = documentDirectoryPath() else {
            print("도큐먼트 위치에 오류가 있어요!")
            return
        }
        
        // 앱 도큐먼트는 복잡하게 구성되어 있겠지만 개중에 Document라고 연결되어 있을 거임
        // 도큐먼트 폴더 내 저장할 경로 설정
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            // 경로에 복구할 파일이 이미 있는지 확인!!
            
            let fileURL = path.appendingPathComponent("yeoniArchive.zip")
            
            do {
                // 같은 파일이 있다면 덮어쓸래? -> overwrite
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }) { unzippedFile in
                    print("압축 해제 완료: \(unzippedFile)")
//                    exit()
                }
            } catch {
                showAlertMessage(title: "압축 해제 실패")
            }
        } else {
            // 경로에 복구할 파일이 없을 때의 대응
            
            
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                let fileURL = path.appendingPathComponent("yeoniArchive.zip")
                
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }) { unzippedFile in
                    print("압축 해제 완료: \(unzippedFile)")
                }
                
            } catch {
                print("압축 해제 실패")
            }
            
        }
        
    }
}


// tableView Code
extension BackupViewController: UITableViewDelegate, UITableViewDataSource {
    /*
     백업
     1. 파일 없음
     2. 저장 공간
     3. 인디케이터
     인디케이터만 만들어 놓고 클릭이 안 되게 안 해 놓음 안댐
     */
    
    func fetchZipList() -> [String] {
        var list: [String] = []
        
        do {
            guard let path = documentDirectoryPath() else { return list }
            let docs = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
            let zip = docs.filter{ $0.pathExtension == "zip" }
            for i in zip {
                list.append(i.lastPathComponent)
            }
        } catch {
            print("error")
        }
        
        return list
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchZipList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = fetchZipList()[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        showActivityViewController(fileName: fetchZipList()[indexPath.row])
        //        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func showActivityViewController(fileName: String) {
        guard let path = documentDirectoryPath() else {
            print("도큐먼트 위치에 오류 있어용")
            return
        }
        
        let backupFileURL = path.appendingPathComponent(fileName)
        let vc = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: [])
        present(vc, animated: true)
    }
}
