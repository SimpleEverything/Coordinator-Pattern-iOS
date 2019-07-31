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
 * 1. KanjiDetailCoordinator‘s presenter is a UINavigationController.
 * 2. Reference to KanjiDetailViewController, which you’re presenting in start().
 * 3. Reference to KanjiListViewController, which you’ll present when a user selects a word.
 * 4. Property to store KanjiStorage, which is passed to KanjiDetailViewController‘s initializer.
 * 5. Property to store the selected kanji.
 * 6. Initialize properties.
 * 7. Create the UIViewController that you want to present.
 * 8. Present the UIViewController that you just created.
 */
class KanjiDetailCoordinator: Coordinator {
    private let presenter: UINavigationController  // 1
    private var kanjiDetailViewController: KanjiDetailViewController? // 2
    private var wordKanjiListViewController: KanjiListViewController? // 3
    private let kanjiStorage: KanjiStorage  // 4
    private let kanji: Kanji  // 5
    
    init(presenter: UINavigationController, // 6
        kanji: Kanji,
        kanjiStorage: KanjiStorage) {
        
        self.kanji = kanji
        self.presenter = presenter
        self.kanjiStorage = kanjiStorage
    }
    
    func start() {
        let kanjiDetailViewController = KanjiDetailViewController(nibName: nil, bundle: nil) // 7
        kanjiDetailViewController.delegate = self
        kanjiDetailViewController.title = "Kanji details"
        kanjiDetailViewController.selectedKanji = kanji
        
        presenter.pushViewController(kanjiDetailViewController, animated: true) // 8
        self.kanjiDetailViewController = kanjiDetailViewController
    }
}

// MARK: - KanjiDetailViewControllerDelegate
extension KanjiDetailCoordinator: KanjiDetailViewControllerDelegate {
    func kanjiDetailViewControllerDidSelectWord(_ word: String) {
        let wordKanjiListViewController = KanjiListViewController(nibName: nil, bundle: nil)
        let kanjiForWord = kanjiStorage.kanjiForWord(word)
        wordKanjiListViewController.kanjiList = kanjiForWord
        wordKanjiListViewController.title = word
        wordKanjiListViewController.cellAccessoryType = .none
        
        presenter.pushViewController(wordKanjiListViewController, animated: true)
    }
}

