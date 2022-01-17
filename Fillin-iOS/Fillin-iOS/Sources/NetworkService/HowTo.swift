//
//  HowTo.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/17.
//

import Foundation

// Service 파일

/*
 Moya 쓰는 방법
 예시로는 HomeAPI, HomeService 파일을 보세요!
 
 1. API 명세서를 본다
 2. ~Service 파일에 가면
 enum HomeService {
     
 }
 이렇게 생긴게 있을 겁니다! 거기 안에 자신의 API의 case를 추가해주세요.
 서버에 아무것도 보내는 것이 없다면 : case latestPhotos
 서버에 보내야 하는 항목이 있다면 : case groupDelete(groupID: Int, defaultGroupId: Int)
 이런식으로 안에 넣어주면 됩니다!
 
 3.
 var path: String {
     switch self {
     case .latestPhotos:
         return "/photo/latest"
     }
 }
 그 다음엔 path를 설정해줄거에요! switch 문 안에 자신의 API의 경로를 작성해줍니다.
 
 4.
 var method: Moya.Method {
     switch self {
     case .latestPhotos:
         return .get
     }
 }
 그 다음엔 method 입니다! 자신의 API의 method를 작성해주세요
 
 5.
 var task: Task {
     switch self {
     case .latestPhotos:
         return .requestPlain
     }
 }
 그 다음엔 request에요!
 - 우리가 서버에게 보내는것 (request)가 없다면 : .requestPlain
 - 우리가 서버에게 보내는 것 (request)가 있다면 : .requestJSONEncodable(자신이 만든 requestModel)
 - 쿼리 (query) 가 있다면 :
 case .cardListFetchInGroup(let cardListInGroupRequest):
     return .requestParameters(parameters: ["userId": cardListInGroupRequest.userId,
                                            "groupId": cardListInGroupRequest.groupId,
                                            "offset": cardListInGroupRequest.offset], encoding: URLEncoding.queryString)
 이런식으로 쿼리의 key값과 value값을 맞춰주면 됩니다.
 
 6.
 var headers: [String: String]? {
     switch self {
     case .latestPhotos:
         return Const.Header.tokenHeader
     }
 }
 그 다음엔 header 입니다!
 우리가 헤더에 넣어서 보내야 하는 값을 잘 봐주세요!
 
 토큰을 같이 보내야 한다면 : return Const.Header.tokenHeader
 토큰을 같이 보내지 않아도 된다면 : .none
 
 여기까지 service 파일을 잘 만들었다면! 다음 API파일로 가봅시다!
 */

// API 파일
/*
 1.
 func latestPhotos(completion: @escaping (NetworkResult<Any>) -> Void) {
     homeProvider.request(.latestPhotos) { (result) in
         switch result {
         case .success(let response):
             let statusCode = response.statusCode
             let data = response.data
             
             let networkResult = self.judgeLatestPhotosStatus(by: statusCode, data)
             completion(networkResult)
             
         case .failure(let err):
             print(err)
         }
     }
 }
 
 이제 함수를 만들거에요!
 만약에 우리가 서버에 보내야 하는 값이 있다면,
 func changeCardGroup(request: ChangeGroupRequest, completion: @escaping (NetworkResult<Any>) -> Void) {
     groupProvider.request(.changeCardGroup(request: request)) { (result) in
         switch result {
         case .success(let response):
             let statusCode = response.statusCode
             let data = response.data

             let networkResult = self.judgeStatus(by: statusCode, data)
             completion(networkResult)
             
         case .failure(let err):
             print(err)
         }
     }
 }
 
 이런식으로 파라미터에 request: 내가만든 request모델 을 넣고,
 각각의Provider.request(.내가사용하는API케이스( ~~~~~
 (여기서 .내가사용하는API케이스 누르면 우리가 Service파일에서 만들어놨기 때문에 자동완성뜰거에요!)
 이렇게 사용하면 된답니다!
 
 2.
 그리고 여기서 중요한건
 let networkResult = self.judgeLatestPhotosStatus(by: statusCode, data)
 요 부분인데요!
 
 private func judgeLatestPhotosStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {

     let decoder = JSONDecoder()
     guard let decodedData = try? decoder.decode(GenericResponse<PhotosResponse>.self, from: data)
     else {
         return .pathErr
     }

     switch statusCode {
     case 200:
         return .success(decodedData.data ?? "None-Data")
     case 400..<500:
         return .requestErr(decodedData.message)
     case 500:
         return .serverErr
     default:
         return .networkFail
     }
 }
 
 이런식으로 각각 API마다 들어오는 Reponse모델을 GenericResponse<PhotosResponse> 여기 부분에 넣고 이 함수를
 self.(여기에넣어주시면됩니다)
 그럼 Service파일도 끝! 이제 뷰컨으로 가봅시다!
 */

//ViewController

/*
 1.
 extension HomeViewController {
     func latestPhotosWithAPI() {
         HomeAPI.shared.latestPhotos { response in
             switch response {
             case .success(let data):
                 if let photos = data as? PhotosResponse {
                     self.serverNewPhotos = photos
                     self.homeTableView.reloadData()
                 }
             case .requestErr(let message):
                 print("latestPhotosWithAPI - requestErr: \(message)")
             case .pathErr:
                 print("latestPhotosWithAPI - pathErr")
             case .serverErr:
                 print("latestPhotosWithAPI - serverErr")
             case .networkFail:
                 print("latestPhotosWithAPI - networkFail")
             }
         }
     }
 }
 
 맨 밑에 Network로 extension 하나 빼서 네트워크 관련 함수들을 작성할거에요!
 이때 이름은 ~WithAPI로 통일해주세요!
 
 2.
 var serverNewPhotos: PhotosResponse?
 
 뷰컨에 서버에서 넘어온 데이터를 받을 변수를 하나 지정해둔뒤,
 case .success(let data):
     if let photos = data as? PhotosResponse {
         self.serverNewPhotos = photos
         self.homeTableView.reloadData()
     }
 
 이 success (서버통신이 성공한다면) 안에서 우리가 선언한 변수에 서버에서 넘어온 데이터들을 넣어주면 됩니다!
 collectionView, tableView를 사용하고 있다면 이 구간에서 reloadData() 를 해줘야해요!
 
 이준이의 모야 가이드 끝
 궁금한게 있으면 언제든 물어보기! 아요 화이팅 :)
 */
