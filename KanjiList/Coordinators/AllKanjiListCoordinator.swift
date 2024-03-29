/// Copyright (c) 2019 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
/*
 * 1. The presenter of AllKanjiListCoordinator is a UINavigationController.
 * 2. Since AllKanjiListCoordinator presents a list of all kanji, it needs a property to access the list.
 * 3. Property to keep a reference to the KanjiListViewController that you’ll be presenting.
 * 4. Property to store KanjiStorage, which is passed to AllKanjiListCoordinator‘s initializer.
 * 5. Initialize properties.
 * 6. Create the UIViewController that you want to present.
 * 7. Push the newly created UIViewController to the presenter.
 */
class AllKanjiListCoordinator: Coordinator {
    private let presenter: UINavigationController  // 1
    private let allKanjiList: [Kanji]  // 2
    private var kanjiListViewController: KanjiListViewController? // 3
    private let kanjiStorage: KanjiStorage // 4
    private var kanjiDetailCoordinator: KanjiDetailCoordinator?
    
    init(presenter: UINavigationController, kanjiStorage: KanjiStorage) {
        self.presenter = presenter
        self.kanjiStorage = kanjiStorage
        allKanjiList = kanjiStorage.allKanji()  // 5
    }
    
    func start() {
        let kanjiListViewController = KanjiListViewController(nibName: nil, bundle: nil) // 6
        kanjiListViewController.delegate = self
        kanjiListViewController.title = "Kanji list"
        kanjiListViewController.kanjiList = allKanjiList
        presenter.pushViewController(kanjiListViewController, animated: true)  // 7
        
        self.kanjiListViewController = kanjiListViewController
    }
}

// MARK: - KanjiListViewControllerDelegate
extension AllKanjiListCoordinator: KanjiListViewControllerDelegate {
    func kanjiListViewControllerDidSelectKanji(_ selectedKanji: Kanji) {
        let kanjiDetailCoordinator = KanjiDetailCoordinator(presenter: presenter,
                                                            kanji: selectedKanji,
                                                            kanjiStorage: kanjiStorage)
        kanjiDetailCoordinator.start()
        self.kanjiDetailCoordinator = kanjiDetailCoordinator
    }
}

