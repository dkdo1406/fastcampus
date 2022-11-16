import RxSwift

let disposeBag = DisposeBag()
print("-------ignoreElements-------")
let 취짐모드 = PublishSubject<String>()

취짐모드
    .ignoreElements()
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)

취짐모드.onNext("스피커 짱짱")
취짐모드.onNext("스피커 짱짱")
취짐모드.onNext("스피커 짱짱")

취짐모드.onCompleted()

print("-------elementAt--------")

let 두번울면깨는사람 = PublishSubject<String>()

두번울면깨는사람
//    .element(at: 2)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

두번울면깨는사람.onNext("롤린롤린롤린")
두번울면깨는사람.onNext("롤린롤린롤린")
두번울면깨는사람.onNext("바나나나바나")
두번울면깨는사람.onNext("롤린롤린롤린")

print("------filter-------")
Observable.of(1, 2, 3, 4, 5, 6, 7, 8)
    .filter {
        $0 % 2 == 0
    }
    .subscribe (onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("------skip-------")
Observable.of(1, 2, 3, 4, 5, 6, 7)
    .skip(5)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("------skipwhile-------")
Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
    .skip(while: {
        $0 != 6
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("------skipuntil-------")
let 손님 = PublishSubject<String>()
let 문여는시간 = PublishSubject<String>()

손님
    .skip(until: 문여는시간)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

손님.onNext("안녕")
손님.onNext("안녕")
손님.onNext("안녕")
손님.onNext("안녕")
문여는시간.onNext("땡")
손님.onNext("안녕!!!!!!!")
손님.onNext("안녕")
손님.onNext("안녕")

print("------take-------")
Observable.of("금메달", "은메달", "동메달", "4등", "5등")
    .take(3)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("------takeWhile-------")
Observable.of("금메달", "은메달", "동메달", "4등", "5등")
    .take(while: {
        $0 != "동메달"
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("------enumerated-------")
Observable.of("금메달", "은메달", "동메달", "4등", "5등")
    .enumerated()
    .takeWhile {
        $0.index < 3
    }
    .subscribe(onNext:  {
        print($0)
    })
    .disposed(by: disposeBag)

print("------takeUntil-------")
let 수강신청 = PublishSubject<String>()
let 신청마감 = PublishSubject<String>()

수강신청
    .take(until: 신청마감)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
수강신청.onNext("나는 성공")
수강신청.onNext("나는 성공")
수강신청.onNext("나는 성공")
수강신청.onNext("나는 성공")
신청마감.onNext("이제 끝")
수강신청.onNext("나는 성공?")
수강신청.onNext("나는 성공?")

print("------distinctUntilChanged-------")
Observable.of("저는", "저는", "저는", "앵무새", "앵무새", "입니다", "입니다", "저는")
    .distinctUntilChanged()
    .subscribe(onNext: {
        print($0)
    })
