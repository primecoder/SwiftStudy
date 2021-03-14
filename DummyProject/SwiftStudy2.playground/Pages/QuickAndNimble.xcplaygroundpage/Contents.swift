/*:

 This page demonstrtes that Quick & Nimble can be imported in and used in Playground.
 However, it appears not to do much! I suggest that it should be run inside *Test* target.

 <<aa-20190505>>

 */

import Quick
import Nimble

class BDD_QuickNimbleTests: QuickSpec {

    func isWorking() -> Bool {
        return true
    }

    override func spec() {

        it("is working") {
            expect(self.isWorking()).to(beTrue())
        }

        context("When project has just been build") {
            it("is working") {
                expect(self.isWorking()).to(beTrue())
            }
        }

        describe("Quick and Nimble") {
            it("is working") {
                expect(self.isWorking()).to(beTrue())
            }
        }

        describe("Quick and Nimble") {
            context("When project has just been build") {
                it("is working") {
                    expect(self.isWorking()).to(beTrue())
                }
            }
        }
    }
}
