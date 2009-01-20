/*
 * Copyright 2007 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.codehaus.groovy.grails.plugins.searchable.test.mapping.dsl.searchablereference.lazy

/**
 * @author Maurice Nicholson
 */
public class LazyTests extends SearchableFunctionalTestCase {

    public getDomainClasses() {
        return [Lazy, NotLazy, Element]
    }

    void testLazy() {
        def lazy = new Lazy(id: 1l)
        def notLazy = new NotLazy(id: 1l)
        for (i in 1..10) {
            def element = new Element(id: i as Long, value: "element ${i}")
            element.index()
            lazy.elements << element
            notLazy.elements << element
        }
        lazy.index()
        notLazy.index()

        notLazy = NotLazy.search("alias:NotLazy", result: 'top')
        assert notLazy
        assert notLazy.elements.size() == 10

        lazy = Lazy.search("alias:Lazy", result: 'top')
        assert lazy
        assert lazy.elements.size() == 10
    }
}