//
//  SurveyDetailCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/12.
//

import UIKit

class SurveyDetailCollectionViewCell: UICollectionViewCell, UITextViewDelegate, UITextFieldDelegate {
    static let ID = "SurveyDetailCollectionViewCell"
    var parentViewController:SurveyDetailViewController?
    let lblQue_Title: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 16)
        return label
    }()
    
    let cvExm = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var exmList:[exmData] = []
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        layer.cornerRadius = 8
        
        
        addSubview(lblQue_Title)
        lblQue_Title.translatesAutoresizingMaskIntoConstraints = false
        lblQue_Title.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
        lblQue_Title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
//        lblQue_Title.numberOfLines = 2
        
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.minimumLineSpacing = 18
        cvLayout.minimumInteritemSpacing = 0
        cvLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvExm.collectionViewLayout = cvLayout
        
        cvExm.delegate = self
        cvExm.dataSource = self
        cvExm.backgroundColor = .white
        addSubview(cvExm)
        cvExm.translatesAutoresizingMaskIntoConstraints = false
        cvExm.topAnchor.constraint(equalTo: lblQue_Title.bottomAnchor, constant: 15).isActive = true
        cvExm.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40).isActive = true
        cvExm.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        cvExm.register(SurveyExmCollectionViewCell.self, forCellWithReuseIdentifier: SurveyExmCollectionViewCell.ID)
        cvExm.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
      
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        let text = textView.text //This the text
        let row = textView.tag //This the indexPath.row
        var answer = exmList[row]
        answer.Exm_Title = text
        parentViewController?.getAnswers(answer: answer)

   }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let text = textField.text //This the text
        var row = textField.tag //This the indexPath.row
        
        if row > 1000 {
            var answer = exmList[row-1000]
            answer.Exm_Title = text
            if let isSelected = answer.isSelected, isSelected {
                parentViewController?.getAnswers(answer: answer)
            }
            
        } else {
            var answer = exmList[row]
            answer.Exm_Title = text
            
            parentViewController?.getAnswers(answer: answer)
        }
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SurveyDetailCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return exmList.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SurveyExmCollectionViewCell.ID, for: indexPath) as! SurveyExmCollectionViewCell
        
        cell.lblExm_Title.text = exmList[indexPath.row].Exm_Title
        if let Exm_Type = exmList[indexPath.row].Exm_Type {
            print("Exm_Type : \(Exm_Type)")
            cell.ivExm.isHidden = true
            cell.ivCheck.isHidden = true
            cell.tvAnswer.isHidden = true
            cell.tvAnswer.delegate = self
            cell.tvAnswer.tag = indexPath.row
            
            cell.tfAnswer.isHidden = true
            cell.tfAnswer.delegate = self
            cell.tfAnswer.tag = indexPath.row
            
            cell.tfRMAnswer.isHidden = true
            cell.tfRMAnswer.delegate = self
            cell.tfRMAnswer.tag = 1000+indexPath.row
            
            switch Exm_Type {
            case "R":
                cell.ivExm.isHidden = false
                cell.tfRMAnswer.text = ""
                if let isSelected = exmList[indexPath.row].isSelected {
                    if isSelected {
                        cell.ivExm.image = UIImage(named: "radio-selected")
                        
                    } else {
                        cell.ivExm.image = UIImage(named: "radio-unselected")
                        
                    }
                    
                } else {
                    cell.ivExm.image = UIImage(named: "radio-unselected")
                    
                }
            case "C":
                cell.ivCheck.isHidden = false
                if let isSelected = exmList[indexPath.row].isSelected {
                    if isSelected {
                        cell.ivCheck.image = UIImage(named: "check2")
                    } else {
                        cell.ivCheck.image = UIImage(named: "uncheck")
                    }
                } else {
                    cell.ivCheck.image = UIImage(named: "uncheck")
                }
            case "T":
                cell.lblExm_Title.isHidden = true
                cell.tvAnswer.isHidden = false
            case "F":
                cell.lblExm_Title.isHidden = true
                cell.tfAnswer.isHidden = false
               
            case "M":
                cell.ivExm.isHidden = false
                cell.lblExm_Title.isHidden = false
                cell.tfRMAnswer.isHidden = false
                
                if let isSelected = exmList[indexPath.row].isSelected {
                    if isSelected {
                        cell.ivExm.image = UIImage(named: "radio-selected")
                    } else {
                        cell.ivExm.image = UIImage(named: "radio-unselected")
                        cell.tfRMAnswer.text = ""
                    }
                    
                } else {
                    cell.ivExm.image = UIImage(named: "radio-unselected")
                    cell.tfRMAnswer.text = ""
                }
                
            default:
                print("")
            }
        }
       
    
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! SurveyExmCollectionViewCell
//        print("clicked : \(exmList[indexPath.row])")
        // 체크 시 다른 라디오 uncheck 되는 부분 작업중
        
        if let Exm_Type = exmList[indexPath.row].Exm_Type {
            switch Exm_Type {
            case "R":
                for (index, item) in exmList.enumerated() {
                    exmList[index].isSelected = false
                }
                if let isSelected = exmList[indexPath.row].isSelected {
                    exmList[indexPath.row].isSelected = !isSelected
                    
                }
                parentViewController?.getAnswers(answer: exmList[indexPath.row])
            case "C":
                if let isSelected = exmList[indexPath.row].isSelected {
                    exmList[indexPath.row].isSelected = !isSelected
                    
                } else {
                    exmList[indexPath.row].isSelected = true
                }
                print("exmList : \(exmList)")
                parentViewController?.getAnswers(answer: exmList[indexPath.row])
                
            case "M":
                for (index, item) in exmList.enumerated() {
                    exmList[index].isSelected = false
                }
                if let isSelected = exmList[indexPath.row].isSelected {
                    exmList[indexPath.row].isSelected = !isSelected
                    
                } else {
                    exmList[indexPath.row].isSelected = true
                }
                print("exmList : \(exmList)")
//                parentViewController?.getAnswers(answer: exmList[indexPath.row])
            default:
                print("")
            }
        }
        
        
//        print("exmList : \(exmList)")
        cvExm.reloadData()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let collectionViewSize = collectionView.frame.size.width
    //        print("collectionViewSize : \(collectionViewSize)")
        var height = 23
        if let Exm_Type = exmList[indexPath.row].Exm_Type {
            switch Exm_Type {
            case "T":
                height = parentViewController?.answerTHeight ?? height
            case "M":
                height = parentViewController?.answerMHeight ?? height
            default:
                print("")
            }                
        }
        return CGSize(width: collectionViewSize, height: CGFloat(height))
        
        
    }
}
