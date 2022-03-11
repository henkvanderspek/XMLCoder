// Copyright (c) 2018-2020 XMLCoder contributors
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT
//
//  Created by Vincent Esche on 11/19/18.
//

struct KeyedBox {
    typealias Key = String
    typealias Attribute = SimpleBox
    typealias Element = Box

    typealias Attributes = KeyedStorage<Key, Attribute>
    typealias Elements = KeyedStorage<Key, Element>

    var elements = Elements()
    var attributes = Attributes()

    var unboxed: (elements: Elements, attributes: Attributes) {
        return (
            elements: elements,
            attributes: attributes
        )
    }

    var value: SimpleBox? {
        return elements.values.first as? SimpleBox
    }
}

extension KeyedBox {
    init<E, A>(elements: E, attributes: A)
        where E: Sequence, E.Element == (Key, Element),
        A: Sequence, A.Element == (Key, Attribute)
    {
        let elements = Elements(elements)
        let attributes = Attributes(attributes)
        self.init(elements: elements, attributes: attributes)
    }
}

extension KeyedBox {
    var dict: [String: String] {
        return attributes.dict
    }
}

extension KeyedBox.Attributes {
    var dict: [String: String] {
        return keys.reduce(into: [:]) {
            $0[$1] = (self[$1].first as? StringBox)?.unboxed ?? ""
        }
    }
}

extension KeyedBox: Box {
    var isNull: Bool {
        return false
    }

    var xmlString: String? {
        return nil
    }
}

extension KeyedBox: CustomStringConvertible {
    var description: String {
        return "{attributes: \(attributes), elements: \(elements)}"
    }
}
