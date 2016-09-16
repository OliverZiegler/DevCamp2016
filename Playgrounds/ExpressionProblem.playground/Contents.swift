/*:
 
 
 # The Expression Problem
 
 ## A solution to the Expression Problem through protocol oriented programming
 
 ---
 
Created by Oliver Ziegler on 20/06/16.
 
Copyright © 2016 Zout Apps, Inh. Oliver Ziegler. All rights reserved.
 */




//: ### Define `Expression` Protocol
protocol Expression {
    associatedtype ReturnType
}

//: ### Define Protocol `const` and add eval struct for it
protocol Const: Expression {
    func const(_ const: Int) -> ReturnType
}

struct Eval: Const {
    typealias ReturnType = Int
    func const(_ const: Int) -> Int {
        return const
    }
}

//: ### Define Protocol `plus` and add eval struct for it
protocol Plus: Expression {
    func plus(_ a: ReturnType, _ b: ReturnType) -> ReturnType
}

extension Eval: Plus {
    func plus(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
}


//: ## We know need to extend our existing code because of reasons

/*:
 
 The main task is to achieve extending our existing code **without** changeing it.
 It could be already compiled in a framework or we just don't want or can't afford to change it because it would take too much time or so.
 
 ---
 
 Because of the protocol oriented way we started implementing we can now easily:
 */

//: ### Add another expression type mult
protocol  Mult: Expression {
    func mult(_ a: ReturnType, _ b: ReturnType) -> ReturnType
}

extension Eval: Mult {
    func mult(_ a: Int, _ b: Int) -> Int {
        return a * b
    }
}

//: ### Add the new operation showEval

struct ShowEval: Const, Plus, Mult {
    typealias ReturnType = String
    
    func const(_ const: Int) -> String {
        return String(const)
    }
    
    func plus(_ a: String, _ b: String) -> String {
        return "(\(a) + \(b))"
    }
    
    func mult(_ a: String, _ b: String) -> String {
        return "(\(a) * \(b))"
    }
}


//: ### Now add another expression

protocol Minus: Expression {
    func minus(_ a: ReturnType, _ b:ReturnType) -> ReturnType
}

extension Eval: Minus {
    func minus(_ a: Int, _ b: Int) -> Int {
        return a - b
    }
}

extension ShowEval: Minus {
    func minus(_ a: String, _ b: String) -> String {
        return "(\(a) - \(b))"
    }
}

//: ## Usage example

let e = Eval()
let result = e.plus(e.mult(e.const(4), e.const(3)), e.const(2))

let s = ShowEval()
let show = s.plus(s.mult(s.const(4), s.const(3)), s.const(2))
