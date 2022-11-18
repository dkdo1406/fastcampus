import RxSwift

let dispoaseBag = DisposeBag()

print("---------replay--------")
"""
구독자가 구독하기 이전 과거에 데이터들을 보고 사용하고 싶을 때 최신순서대로 받아 사용 가능
"""
let 인사말 = PublishSubject<String>()
let 반복하는앵무새 = 인사말.replay(1)

반복하는앵무새.connect() //replay는 사이즈를 가지며 connect를 해줘야 한다.

인사말.onNext("1. Hello")
인사말.onNext("2. Hi")

반복하는앵무새
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: dispoaseBag)

인사말.onNext("3. 안녕하세요")

print("---------replayAll--------")
// 구독한시점 이전 값을 모두 가져와 볼 수 있다.
let 닥터스트레인지 = PublishSubject<String>()
let 타임스톤 = 닥터스트레인지.replayAll()
타임스톤.connect()

닥터스트레인지.onNext("도르마무")
닥터스트레인지.onNext("거래를 하러왔다")

타임스톤
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: dispoaseBag)

print("---------buffer--------")
//let source = PublishSubject<String>()
//
//var count = 0
//let timer = DispatchSource.makeTimerSource()
//
//timer.schedule(deadline: .now() + 2, repeating: .seconds(1))
//timer.setEventHandler {
//    count += 1
//    source.onNext("\(count)")
//}
//timer.resume()
//
//source
//    .buffer(timeSpan: .seconds(2), count: 2, scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: dispoaseBag)

print("---------window--------")
let 만들어낼최대Observable수 = 1
let 만들시간 = RxTimeInterval.seconds(2)

let window = PublishSubject<String>()

var windowCount = 0
let windowTimerSource = DispatchSource.makeTimerSource()
windowTimerSource.schedule(deadline: .now() + 2, repeating: .seconds(1))
windowTimerSource.setEventHandler {
    windowCount += 1
    window.onNext("\(windowCount)")
}
windowTimerSource.resume()

window
    .window(timeSpan: 만들시간,
            count: 만들어낼최대Observable수,
            scheduler: MainScheduler.instance
    )
    .flatMap { windowObservable -> Observable<(index: Int, element: String)> in
        return windowObservable.enumerated()
    }
    .subscribe(onNext: {
        print("\($0.index)번째 Observable의 요소 \($0.element)")
    })
    .disposed(by: dispoaseBag)
