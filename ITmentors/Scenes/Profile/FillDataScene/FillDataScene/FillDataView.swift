//
//  FillDataView.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 22.11.2022.
//


import UIKit
protocol FillDataViewDelegate: AnyObject, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func selectLanguageTransition()
    func confirmError()
    func confirmSuccess(with: FillData.LoadDataOnServer.Request)
    func alertOfInvalidRef()
    func presentAlert(_ alert: UIAlertController)
    func presentImagePicker(_ picker: UIImagePickerController)
    func dismiss()
}
class FillDataView: UIView, UINavigationControllerDelegate {
    weak var delegate: FillDataViewDelegate?
    
        var viewModel: FillData.TransferDataFromProfileToEditScreen.ViewModel? {
            didSet{
                guard let viewModel = viewModel else {return}
                messageLink.text = viewModel.messageLink
                name.text = viewModel.name
                shortDiscription.text = viewModel.shortDiscription
                discription.text = viewModel.discription
                arrayOfLanguages = viewModel.languages
                selectedImageView.image = UIImage(data: viewModel.imageData ?? Data())
                
                layoutCollectionView()
                print(1)

            }
        }
    
    var imagePicker = UIImagePickerController()
    var arrayOfLanguages: [Language] = []
    
// MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .AppPalette.backgroundColor
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Subviews
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = UIColor.AppPalette.backgroundColor
        sv.isScrollEnabled = true
        return sv
    }()


    private let selectedImageView: UIImageView = {
      let iv = UIImageView()
        iv.backgroundColor = .darkGray
        iv.layer.borderColor = UIColor.AppPalette.thirdElementColor.cgColor
        iv.layer.borderWidth = 2
        iv.isUserInteractionEnabled = true
        iv.clipsToBounds = true
        return iv
    }()
    private let imageViewHeader: UILabel = {
        let l = UILabel()
        l.textColor = .darkGray
        l.text = "Выберите ваше фото"
        l.textAlignment = .center

        return l
    }()
    private let shortDiscription: UITextField = {
        var textField = UITextField()
        textField.text = "Например: Senior IOS dev"
        textField.backgroundColor = UIColor.AppPalette.secondElementColor
        textField.textColor = .lightGray
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.returnKeyType = UIReturnKeyType.continue
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.layer.borderColor = UIColor.AppPalette.thirdElementColor.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 10
        return textField

    }()
    private let shortDiscriptionLabel: UILabel = {
        let l = UILabel()
        l.textColor = .darkGray
        l.text = "Введите краткое описание"
        l.textAlignment = .center

        return l
    }()
    private let messageLink: UITextField = {
        var textField = UITextField()
        textField.text = "Например: https://t.me/escaping_closure"
        textField.backgroundColor = UIColor.AppPalette.secondElementColor
        textField.textColor = .lightGray
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.returnKeyType = UIReturnKeyType.continue
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.layer.borderColor = UIColor.AppPalette.thirdElementColor.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 10
        return textField

    }()
    private let messageLinkLabel: UILabel = {
        let l = UILabel()
        l.textColor = .darkGray
        l.text = "!Ссылка! для связи с вами"
        l.textAlignment = .center

        return l
    }()
    
    private let name: UITextField = {
        var textField = UITextField()
        textField.text = "Например: Владимир"
        textField.backgroundColor = UIColor.AppPalette.secondElementColor
        textField.textColor = .lightGray
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.returnKeyType = UIReturnKeyType.continue
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.layer.borderColor = UIColor.AppPalette.thirdElementColor.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 10
        return textField
    }()
    private let nameLabel: UILabel = {
        let l = UILabel()
        l.textColor = .darkGray
        l.text = "Как вас зовут?"
        l.textAlignment = .center

        return l
    }()
    
    private let discription: UITextView = {
        var textView = UITextView()
        textView.text = "Например: Помогаю новичкам со входом в IT. Подскажу на счет резюме и проведу мок собес."

        textView.font = UIFont.systemFont(ofSize: 15)
        textView.backgroundColor = UIColor.AppPalette.secondElementColor
        textView.textColor = .lightGray
        textView.isScrollEnabled = false
        textView.layer.borderColor = UIColor.AppPalette.thirdElementColor.cgColor
        textView.layer.borderWidth = 2
        textView.layer.cornerRadius = 10
        return textView

    }()
    private let discriptionLabel: UILabel = {
        let l = UILabel()
        l.textColor = .darkGray
        l.text = "Введите подробное описание"
        l.textAlignment = .center
        return l
    }()

    private let confirmButton: UIButton = {
        let b = UIButton()
        b.backgroundColor = .AppPalette.thirdElementColor
        b.setTitle("Сохранить", for: .normal)
        b.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        b.layer.cornerRadius = 10
       return b
    }()
    
    private let selectLanguagesButton: UIButton = {
        let b = UIButton()
        b.backgroundColor = .AppPalette.thirdElementColor
        b.setTitle("Выбрать языки программирования", for: .normal)
        b.addTarget(self, action: #selector(selectLanguageTransition), for: .touchUpInside)
        b.layer.cornerRadius = 10
      return b
    }()
    
    private let collectionViewOfLanguages: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 6
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
       return collectionView
    }()
    
    //MARK: - #selectors
    @objc private func selectLanguageTransition(){
        delegate?.selectLanguageTransition()
    }
    
    @objc private func confirm(){
        guard let photoData = selectedImageView.image?.pngData(), let shortDiscriptionn = shortDiscription.text, shortDiscriptionn != "", shortDiscriptionn != "Например: Senior IOS dev", let discriptionn = discription.text, discriptionn != "", discriptionn != "Например: Помогаю новичкам со входом в IT. Подскажу на счет резюме и проведу мок собес.", let name = name.text, name != "", name != "Например: Владимир", arrayOfLanguages.count > 0, let link = messageLink.text, link != "", link != "Например: https://t.me/escaping_closure" else {
            // if not okey
            delegate?.confirmError()
            return
        }
        //if okey
        let request = FillData.LoadDataOnServer.Request(name: name, discription: discriptionn, imageData: photoData, languages: arrayOfLanguages, messageLink: link, shortDiscription: shortDiscriptionn)
        delegate?.confirmSuccess(with: request)

    }
}


//MARK: - subviews & constraints
extension FillDataView{
    private func setConstraints() {
        hideKeyboardWhenTappedAround()
        
//        scrollView.delegate = self
//        scrollView.contentSize = CGSize(width:self.view.frame.size.width, height: 1000)

        discription.delegate = self
        shortDiscription.delegate = self
        name.delegate = self
        messageLink.delegate = self
        let screensize: CGRect = UIScreen.main.bounds
        let imageViewWidth = screensize.width * 0.6
        let itemsWidth = screensize.width * 0.85

        scrollView.contentSize = CGSize(width: screensize.width, height: 900)
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        addSubview(scrollView)

        scrollView.addSubview(selectedImageView)
        scrollView.addSubview(imageViewHeader)
        scrollView.addSubview(name)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(shortDiscription)
        scrollView.addSubview(shortDiscriptionLabel)
        scrollView.addSubview(discription)
        scrollView.addSubview(discriptionLabel)
        scrollView.addSubview(messageLink)
        scrollView.addSubview(messageLinkLabel)
        scrollView.addSubview(selectLanguagesButton)

        scrollView.snp.makeConstraints { make in
            make.top.right.left.bottom.equalToSuperview()

        }

        selectedImageView.snp.makeConstraints { make in
            make.top.equalTo(imageViewHeader.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(imageViewWidth)
            make.height.equalTo(selectedImageView.snp.width)
        }
        selectedImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapAddPhoto)))
        selectedImageView.layer.cornerRadius = imageViewWidth / 2

        imageViewHeader.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scrollView.snp.top).offset(20)
            
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(selectedImageView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }

        name.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(itemsWidth)
            make.height.equalTo(40)
            make.top.equalTo(nameLabel.snp.bottom).offset(7)
        }
        shortDiscriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }

        shortDiscription.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(itemsWidth)
            make.height.equalTo(40)
            make.top.equalTo(shortDiscriptionLabel.snp.bottom).offset(7)
        }

        discriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(shortDiscription.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        discription.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(itemsWidth)
            make.top.equalTo(discriptionLabel.snp.bottom).offset(7)
        }
        messageLinkLabel.snp.makeConstraints { make in
            make.top.equalTo(discription.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }

        messageLink.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(itemsWidth)
            make.height.equalTo(40)
            make.top.equalTo(messageLinkLabel.snp.bottom).offset(7)
        }
        
        selectLanguagesButton.snp.makeConstraints { make in
            make.top.equalTo(messageLink.snp.bottom).offset(30)
            make.width.equalTo(itemsWidth)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
    func layoutCollectionView(){
        let screensize: CGRect = UIScreen.main.bounds
        let itemsWidth = screensize.width * 0.9
        var heigth = 0
        //calculate collectionViewHeight
        for i in 1...arrayOfLanguages.count + 1 {if i % 3 == 0{heigth += 35}}
        if heigth == 0 {heigth = 30}
        

        if scrollView.contains(collectionViewOfLanguages){
            collectionViewOfLanguages.reloadData()
            collectionViewOfLanguages.snp.remakeConstraints { make in
                make.top.equalTo(selectLanguagesButton.snp.bottom).offset(15)
                make.width.equalTo(itemsWidth)
                make.centerX.equalToSuperview()
                make.height.equalTo(heigth)
            }
        } else {
            scrollView.addSubview(collectionViewOfLanguages)
            collectionViewOfLanguages.delegate = self
            collectionViewOfLanguages.dataSource = self
            collectionViewOfLanguages.register(LanguageCollectionViewCell.self, forCellWithReuseIdentifier: "LanguageCell")
            
            collectionViewOfLanguages.snp.makeConstraints { make in
                make.top.equalTo(selectLanguagesButton.snp.bottom).offset(15)
                make.width.equalTo(itemsWidth)
                make.centerX.equalToSuperview()
                make.height.equalTo(heigth)
            }
        }
        
        
        
        guard arrayOfLanguages.count >= 1 else {confirmButton.removeFromSuperview(); return}
        
        scrollView.addSubview(confirmButton)
        
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(collectionViewOfLanguages.snp.bottom).offset(30)
            make.width.equalTo(itemsWidth)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
    }
}
//MARK: - ImagePickerdelegate
extension FillDataView: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Photo has picked1")
        guard let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        selectedImageView.image = pickedImage
//        dismiss(animated: true, completion: nil)
        delegate?.dismiss()
    }


    @objc func didTapAddPhoto(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Photo Gallery", style: .default, handler: { [delegate, imagePicker] (button) in
            self.imagePicker.sourceType = .photoLibrary
            delegate?.presentImagePicker(imagePicker)
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        delegate?.presentAlert(alert)
    }
}

//MARK: - ScrollViewDelegate
extension FillDataView: UIScrollViewDelegate{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            stoppedScrolling()
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        stoppedScrolling()
    }

    func stoppedScrolling() {
        // done, do whatever
    }

}

//MARK: - TextViewDelegate
extension FillDataView: UITextViewDelegate{
    func textViewDidBeginEditing (_ textView: UITextView) {
        if discription.text == "Например: Помогаю новичкам со входом в IT. Подскажу на счет резюме и проведу мок собес."{
            discription.text = ""
            discription.textColor = .white
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
//        textView.textColor = .darkGray
    }
}
//MARK: - TextFieldDelegate
extension FillDataView: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.endEditing(false)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == messageLink{
            let linkChecker = CheckerIfStringIsLink()
            guard let text = textField.text else {return}
            let isLink = linkChecker.check(text)
            if isLink == false{
                textField.text = ""
                delegate?.alertOfInvalidRef()
                endEditing(false)
            }
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField{
        case shortDiscription:
            if textField.text == "Например: Senior IOS dev"{
                textField.text = ""
            }
        case messageLink:
            if textField.text == "Например: https://t.me/escaping_closure"{
                textField.text = ""
            }
        case name:
            if textField.text == "Например: Владимир"{
                textField.text = ""
            }
        default:
            print("nothing to do")
        }
    }
}


//MARK: UICollectionViewDataSource
extension FillDataView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }

}
//MARK: UICollectionViewDataSource

extension FillDataView: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfLanguages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LanguageCell", for: indexPath) as! LanguageCollectionViewCell
        cell.setup(language: arrayOfLanguages[indexPath.row])

        return cell
    }
}


//MARK: UICollectionViewDelegateFlowLayout
extension FillDataView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: bounds.width * 0.3, height: 30)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let CellWidth = Int(bounds.width * 0.3)
        let CellCount = collectionView.numberOfItems(inSection: 0)
        let CellSpacing = 5
        let collectionViewWidth = collectionView.frame.width
        guard CGFloat(CellWidth * CellCount) < collectionViewWidth else {return UIEdgeInsets()}
        let totalCellWidth = CellWidth * CellCount
        let totalSpacingWidth = CellSpacing * (CellCount - 1)

        let leftInset = (collectionViewWidth - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset

        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
}

