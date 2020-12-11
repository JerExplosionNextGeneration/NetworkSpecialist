//
//  UsrLiszViewM.swift
//  RingoCoding
//
//  Created by Jerry Ren on 12/10/20.
//  Copyright © 2020 JerExplosion. All rights reserved.
//

import Foundation

class UsrLiszViewM {
    
    private let alertPresenter: AlertPresenter
    private let usersService: UserListService
    var updateLoadingState: ((LoadingState) -> Void)?
    weak var delegate: UserListViewModelDelegate?
    private let errorTitle = "Error!"
    private let errorMessage = "We are not able to fetch users list. Do you want to try again?\n(Error Code: %d)"
    
    init(alertPresenter: AlertPresenter, usersService:UserListService){
        self.alertPresenter = alertPresenter
        self.usersService = usersService
    }
    
    // MARK: - Requirements extracted / Dec 10th Codility
    
    // fetching a list of users, returning them in the correct order
    // if fetch fails, display alterpresenter (Two scenarios: 1, alert message 2, fetch again
    // inform the user about fetching process by updateloadingstate 1, .loading  2, .normal
    // be careful about memory leaks, only fill in the fetchusers nothing else
    
    func fetchUsersSubmittedVersion() {
        updateLoadingState?(LoadingState.loading)
        usersService.fetchUsers{ [unowned self] (result) in
            
            switch result {
            case .failure(let err):
                self.updateLoadingState?(LoadingState.normal)
                let completeErroMessage = String(format: self.errorMessage, err.code)
                
                self.alertPresenter.presentDecisionAlert(title: self.errorTitle, message: completeErroMessage, onYes: {
                    self.fetchUsersSubmittedVersion()
                }, onNo: {
                    self.delegate?.viewModelCloseList(self)
                })
                
            case .success(let usersArr):
                self.updateLoadingState?(LoadingState.normal)
                self.delegate?.viewModel(self, didFetchUsersList: usersArr.sorted
                { $0.name < $1.name })
            }
        }
    }
    
    
    // MARK: - 我自己的解答, 只有过了八成半的test cases
    
    fileprivate func fetchUsersWeakselfVersion() {
        
        guard let loadingStateUpdated = updateLoadingState else { return }
        loadingStateUpdated(.loading)
        
        usersService.fetchUsers { [weak self] result in
            guard let strongSelf = self else { return}  // is it better to unwrap or directly use unowned?
            
            switch result {
            case .failure(let err):
                
                loadingStateUpdated(LoadingState.normal)
                let completeErrMessage = String(format: strongSelf.errorMessage, err.code)
                
                strongSelf.alertPresenter.presentDecisionAlert(title: strongSelf.errorTitle, message: strongSelf.errorMessage) {
                    strongSelf.fetchUsersWeakselfVersion()
                    loadingStateUpdated(.loading)               // be cautious about onYes
                } onNo: {
                    strongSelf.delegate?.viewModelCloseList(strongSelf)
                }
                
            case .success(let userArr):
                let sortedUsers = userArr.sorted { $0.name < $1.name }
                strongSelf.delegate?.viewModel(strongSelf, didFetchUsersList: sortedUsers)
            }
        }
    }
}











