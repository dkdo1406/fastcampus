import RxSwift

let disposeBag = DisposeBag()

print("-------startWihd--------")
let 노랑반 = Observable<String>.of("철수", "영희", "맹구")

노랑반
    .enumerated()
    .map { index, element in
        return element + "어린이" + "\(index)"
    }
    .startWith("선생님")
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------concat1----------")
let 노랑반어린이들 = Observable<String>.of("철수", "영희", "맹구")
let 선생님 = Observable<String>.of("선생님")

let 줄서서걷기 = Observable
    .concat([선생님, 노랑반어린이들])

줄서서걷기
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------concat2----------")
선생님
    .concat(노랑반어린이들)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------concatMap----------") // flatMap observable 방출된 것들이 합쳐짐
let 어린이집: [String: Observable<String>] = [
    "노랑반": Observable.of("철수", "영희", "맹구"),
    "파랑반": Observable.of("장미", "미진")
]

Observable.of("노랑반", "파랑반")
    .concatMap { 반 in
        어린이집[반] ?? .empty()
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------merge1---------")
let 강북 = Observable.from(["강북구", "성북구", "동대문구", "종로구"])
let 강남 = Observable.from(["강남구", "강동구", "영등포구", "양천구"])

Observable.of(강북, 강남)
    .merge() // 순서를 보장하지 않는다.
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------merge2---------")
Observable.of(강북, 강남)
    .merge(maxConcurrent: 1) //한번에 받을 observable을 말함 즉, 순서를 보장한다.
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------combineLatest1---------")
let 성 = PublishSubject<String>()
let 이름 = PublishSubject<String>()

let 성명 = Observable
    .combineLatest(성, 이름) { 성, 이름 in
        성 + 이름
    }
성명
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
                   
성.onNext("김")
이름.onNext("똘똘")
이름.onNext("영수")
이름.onNext("은영")
성.onNext("박")
성.onNext("이")
성.onNext("조")
                   
print("---------combineLatest2---------")
let 날짜표시형식 = Observable<DateFormatter.Style>.of(.short, .long)
let 현재날짜 = Observable<Date>.of(Date())

let 현재날짜표시 = Observable
    .combineLatest(날짜표시형식, 현재날짜, resultSelector: { 형식, 날짜 -> String in
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = 형식
        return dateFormatter.string(from: 날짜)
    })

현재날짜표시
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------combineLatest3---------")
let lastName = PublishSubject<String>()
let firstName = PublishSubject<String>()

let fullName = Observable
    .combineLatest([firstName, lastName]) { name in
        name.joined(separator: " ")
    }
fullName
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

lastName.onNext("Kim")
firstName.onNext("Paul")
firstName.onNext("Stella")
firstName.onNext("Lily")

print("---------zip---------")
// 2개이상의 Observable을 묶어서 방출하는 함수
// 한쪽의 element가 끝나면 zip도 끝나게 된다.
enum 승패 {
    case 승
    case 패
}

let 승부 = Observable<승패>.of(.승, .승, .패, .패, .승)
let 선수 = Observable<String>.of("한국", "미국", "영국", "일본")

let 시합결과 = Observable
    .zip(승부, 선수) { 결과, 대표선수 in
        return 대표선수 + "선수" + " \(결과)"
    }
시합결과
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("---------withLatestFrom1---------")
let 트리거 = PublishSubject<Void>()
let 달리기선수 = PublishSubject<String>()

트리거
    .withLatestFrom(달리기선수) // 최신의 값만 방출한다.
//    .distinctUntilChanged() // 동일한 이벤트는 걸러주기 때문에 sample과 동일하게 동작한다.
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

달리기선수.onNext("사람1")
달리기선수.onNext("사람1사람2")
달리기선수.onNext("사람1사람2사람3")
트리거.onNext(Void())
트리거.onNext(Void())

print("---------sample---------")
//단 한번만 방출한다.
let 출발 = PublishSubject<Void>()
let F1선수 = PublishSubject<String>()

F1선수
    .sample(출발)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

F1선수.onNext("선수1")
F1선수.onNext("선수1    선수2")
F1선수.onNext("선수1  선수2   선수3")
출발.onNext(Void())
출발.onNext(Void())
출발.onNext(Void())

print("---------amb---------")
let 버스1 = PublishSubject<String>()
let 버스2 = PublishSubject<String>()

let 버스정류장 = 버스1.amb(버스2) // 요소를 먼저 방출하는 친구가 생기면 다음 것을 구독하지 않음
// 이 코드에서는 버스1과 버스2를 보다가 먼저오는 버스2를 구독 후 버스1은 구독하지 않음

버스정류장
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

버스2.onNext("버스2-승객0: 사람1")
버스1.onNext("버스1-승객0: 사람2")
버스1.onNext("버스1-승객1: 사람3")
버스2.onNext("버스2-승객1: 사람4")
버스1.onNext("버스1-승객1: 사람5")
버스2.onNext("버스2-승객2: 사람6")

print("---------switchLatest---------")
let 학생1 = PublishSubject<String>()
let 학생2 = PublishSubject<String>()
let 학생3 = PublishSubject<String>()

let 손들기 = PublishSubject<Observable<String>>()

let 손든사람만말할수있는교실 = 손들기.switchLatest()
"""
SourceObservable 즉 손들기라는 것이 된다.
손들기로 들어온 마지막 시퀀스 아이템만 구독하는 것이 특징이다.
"""


손든사람만말할수있는교실
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

손들기.onNext(학생1)
학생1.onNext("학생1: 저는 1번 학생입니다.")
학생2.onNext("학생2: 저요 저요 저요!")

손들기.onNext(학생2)
학생2.onNext("학생2: 저는 2번 학생입니다.")
학생1.onNext("학생1: 저요 저요 저요!")

손들기.onNext(학생3)
학생2.onNext("학생2: 저는 2번 학생입니다.")
학생1.onNext("학생1: 저는 언제 말하죠?")
학생3.onNext("학생3: 저는 3번 학생입니다. 제가 이겼는 것 같네요 ㅎ")

손들기.onNext(학생1)
학생1.onNext("학생1: 내가 이겼어!")
학생2.onNext("학생2: ㅠㅠ")
학생3.onNext("학생3: 이긴 줄 알았는데 ㅠ")
학생2.onNext("학생2: 이거 이기고 지는 손들기였나요?")

print("---------reduce---------")
// 제공된 초기값부터 값이 나올때마다 결합을 해주고 결과값만 방출
Observable.from((1...10))
//    .reduce(0, accumulator: { summary, newValue in
//        return summary + newValue
//    })
//    .reduce(0) { summary, newValue in
//        return summary + newValue
//    }
    .reduce(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------scan---------")
// 매번 들어온 값들을 방출시켜 준다.
Observable.from((1...10))
    .scan(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
