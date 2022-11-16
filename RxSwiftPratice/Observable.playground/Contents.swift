import Foundation
import RxSwift

print("------Just-----")
Observable<Int>.just(1)
    .subscribe(onNext: {
        print($0)
    })

print("-----Of--------")
Observable<Int>.of(1, 2, 3, 4, 5)
    .subscribe(onNext: {
        print($0)
    })

print("-----Of2-------")
Observable.of([1, 2, 3, 4, 5]) // == 배열 모두가 리턴, just와 같다.
    .subscribe(onNext: {
        print($0)
    })

print("----From-------")
Observable.from([1, 2, 3, 4, 5]) // array안에 하나하나씩 들어간다.
    .subscribe(onNext: {
        print($0)
    })

print("----subscribe-------")
Observable.of(1,2,3)
    .subscribe {
        print($0)
    }

print("----subscribe2-------")
Observable.of(1,2,3)
    .subscribe {
        if let element = $0.element {
            print(element)
        }
    }
print("----subscribe3-------")
Observable.of(1,2,3)
    .subscribe(onNext: {
        print($0)
    })
print("----empty-------")
Observable<Void>.empty()
    .subscribe {
        print($0)
    }

print("----never-------")
Observable<Void>.never()
    .debug("never")
    .subscribe(onNext: {
    print($0)
    },
               onCompleted: {
        print("Completed")
    }
    )

print("----range-------")
Observable.range(start: 1, count: 9)
    .subscribe(onNext: {
        print("2*\($0) = \(2*$0)")
    })

print("----dispose-------")
Observable.of(1,2,3)
    .subscribe {
        print($0)
    }
    .dispose()
let disposeBag = DisposeBag()
print("----disposeBag-------")
Observable.of(1,2,3)
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)

print("----create-------")
Observable.create { observer -> Disposable in
    observer.onNext(1)
//    observer.on(.next(1))
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}
.subscribe {
    print($0)
}
.disposed(by: disposeBag)

print("----create2-------")
enum MyError: Error {
    case anError
}
Observable.create { observer -> Disposable in
    observer.onNext(1)
    observer.onError(MyError.anError)
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}
.subscribe (
    onNext: {
        print($0)
    },
    onError: {
        print($0.localizedDescription)
    },
    onCompleted: {
        print("Completed")
    },
    onDisposed: {
        print("dispose")
    }
)
.disposed(by: disposeBag)

print("----deferred1-------")
Observable.deferred {
    Observable.of(1,2,3)
}
.subscribe {
    print($0)
}
.disposed(by: disposeBag)

print("----deferred2-------")
var 뒤집기: Bool = false

let factory: Observable<String> = Observable.deferred {
    뒤집기 = !뒤집기
    
    if 뒤집기 {
        return Observable.of("👏")
    } else {
        return Observable.of("👊")
    }
}

for _ in 0...3 {
    factory.subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
}
