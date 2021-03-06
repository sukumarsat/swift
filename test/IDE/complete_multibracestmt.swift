// RUN: %target-swift-ide-test -batch-code-completion -source-filename %s -filecheck %raw-FileCheck -completion-output-dir %t

enum E {
  case bar
  case foo
}

func test(pred: Bool) {
    var e: E
    if pred {
        e = .#^THEN?check=CHECK^#
    } else {
        e = .#^ELEE?check=CHECK^#
    }

    do {
        e = .#^DO?check=CHECK^#
    } catch e {
        e = .#^CATCH?check=CHECK^#
    }

    switch pred {
    case true:
        e = .#^CASE_1?check=CHECK^#
        break;
    case false:
        e = .#^CASE_2?check=CHECK^#
        break;
    default:
        e = .#^DEFAULT?check=CHECK^#
        break;
    }
}

// CHECK: Begin completions, 3 items
// CHECK: Decl[EnumElement]/ExprSpecific/TypeRelation[Identical]: bar[#E#]; name=bar
// CHECK: Decl[EnumElement]/ExprSpecific/TypeRelation[Identical]: foo[#E#]; name=foo
// CHECK: Decl[InstanceMethod]/CurrNominal/TypeRelation[Invalid]: hash({#(self): E#})[#(into: inout Hasher) -> Void#]; name=hash(self: E)
// CHECK: End completions
