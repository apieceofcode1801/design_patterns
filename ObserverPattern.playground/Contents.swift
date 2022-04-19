import UIKit

class Subject {
    private var observers: [Observer] = []
    private(set) var state: Int = 0
    
    func setState(_ state: Int) {
        self.state = state
        notifyAllObservers()
    }
    
    func attach(_ observer: Observer) {
        observers.append(observer)
    }
    
    func notifyAllObservers() {
        for observer in observers {
            observer.update()
        }
    }
}

protocol Observer {
    var subject: Subject { get }
    func update()
}

class BinaryObserver: Observer {
    var subject: Subject
    
    init(subject: Subject) {
        self.subject = subject
        self.subject.attach(self)
    }
    
    func update() {
        print("Binary String: \(String(subject.state, radix: 2))")
    }
}

class OctalObserver: Observer {
    var subject: Subject
    
    init(subject: Subject) {
        self.subject = subject
        self.subject.attach(self)
    }
    
    func update() {
        print("Octal String: \(String(subject.state, radix: 0o10, uppercase: false))")
    }
}

class HexaObserver: Observer {
    var subject: Subject
    
    init(subject: Subject) {
        self.subject = subject
        self.subject.attach(self)
    }
    
    func update() {
        print("Hex String: \(String(format:"%2X", subject.state))")
    }
}

let subject = Subject()
HexaObserver(subject: subject)
OctalObserver(subject: subject)
BinaryObserver(subject: subject)

print("First state change: 15")
subject.setState(15)
print("Second state change: 10")
subject.setState(10)
