//  ExpandedView.swift
//  Skully Pack Plus
//  Created by Jacob Dobson on 7/8/17.
//  Copyright © 2017 Jacob Dobson. All rights reserved.
import UIKit
import Messages
class ExpandedView: UICollectionViewController {
    //computed property
    var screenW: CGFloat {
		return UIScreen.main.bounds.width
    }
    //globals
    lazy var data = [MSSticker]() //MSSticker is an object with fileURL that points to asset on disk
    //life cycle
	override func viewWillAppear(_ animated: Bool) {
		loadStickers()
	}
    override func viewDidLoad() {
        super.viewDidLoad()
		self.collectionView?.clipsToBounds = true
        self.collectionView?.contentInset = UIEdgeInsets(top: 		screenW * 0.1,
                                                         left: 		screenW * 0.1,
                                                         bottom: 	screenW * 0.1,
                                                         right: 	screenW * 0.1)
    }
//MARK: helper funcs
    func createSticker(img: String, localizedDescription: String) {
        guard let path = Bundle.main.path(forResource: img, ofType: "png") else {
            print("COULD NOT CREATE \(localizedDescription)")
            return
        }
        let url = URL(fileURLWithPath: path)
        let sticker: MSSticker
        do {
            try sticker = MSSticker(contentsOfFileURL: url, localizedDescription: localizedDescription)
            data.append(sticker)
        } catch {
            print(error)
            return
        }
    }

    func loadStickers() {
		createSticker(img: "skullyCrossbonesOld",	localizedDescription: "skullyCrossbonesOldSticker")
		createSticker(img: "skullyRunning",		localizedDescription: "skullyRunningSticker")
		createSticker(img: "skullyFloating",		localizedDescription: "skullyFloatingSticker")
		createSticker(img: "skullyHanging",		localizedDescription: "skullyHangingSticker")
		createSticker(img: "skullyCelebrate",		localizedDescription: "skullyCelebrateSticker")
		createSticker(img: "skullyBaseball",		localizedDescription: "skullyBaseballSticker")
		createSticker(img: "skullyPiece",		localizedDescription: "skullyPieceSticker")
		createSticker(img: "skullyBeverage",		localizedDescription: "skullyBeverageSticker")
		createSticker(img: "boycott",			localizedDescription: "boycottSticker")
		createSticker(img: "coolGhost",			localizedDescription: "coolGhostSticker")
		createSticker(img: "coolTombstone",		localizedDescription: "coolTombstoneSticker")
		createSticker(img: "stayPositive",		localizedDescription: "stayPostiveSticker")
		createSticker(img: "numberOne",			localizedDescription: "numberOneSticker")
		createSticker(img: "killMe",				localizedDescription: "killMeSticker")
		createSticker(img: "brew",				localizedDescription: "brewSticker")
		createSticker(img: "flag",				localizedDescription: "flagSticker")
		createSticker(img: "hair",				localizedDescription: "hairSticker")
		createSticker(img: "shadeLincoln",		localizedDescription: "shadeLincolnSticker")
		createSticker(img: "sweetBabyJesus",		localizedDescription: "sweetBabyJesusSticker")
		createSticker(img: "alluminaughty",		localizedDescription: "alluminaughtySticker")
		createSticker(img: "pentaGraham",		localizedDescription: "pentaGrahamSticker")
		createSticker(img: "planet",				localizedDescription: "planetSticker")
    }
}
//MARK: UICollectionViewDataSource
extension ExpandedView: UICollectionViewDelegateFlowLayout { //conforming to datasource and delegate also by inheritance
	//number of items in collection view
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    //create cells
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = data[indexPath.row]
        return deQStickerCell(for: item, at: indexPath)
    }
	//helper funcs
    //dequeue cell as sticker, then use callback when creating cell in "cellForItemAt" func
    private func deQStickerCell(for sticker: MSSticker, at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView?.dequeueReusableCell(withReuseIdentifier: "ExpandedCell", for: indexPath) as! StickerExpandedCell
        cell.stickerExpandedView.sticker = sticker
        return cell
    }
//MARK: UICollectionViewDelegateFlowLayout
    //layout -- sizing, spacing
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
		let margins = 		screenW * 0.2
		let minusMargins = 	screenW - margins
		let itemSize = 		minusMargins / 5
        return CGSize(width: itemSize, height: itemSize)
    }
    //min item spacing
    func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return screenW * 0.15
    }
    //min line spacing
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return screenW * 0.1
    }
}
