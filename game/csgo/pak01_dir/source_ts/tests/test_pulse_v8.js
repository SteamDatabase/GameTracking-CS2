import { Instance } from "domains/testdomain";
// ----------------------
function TEST_EQ(sTestName, actual, expected) {
    if (actual === expected) {
        Instance.Log(`Test Passed: ${sTestName}`);
    }
    else {
        Instance.Log(`Test FAILED: ${sTestName}`);
        Instance.Log(`\texpected "${actual}" to equal ${expected}`);
    }
}
// ----------------------
TEST_EQ("Domain.keys.isArray", Array.isArray(Object.keys(Instance)), true);
// ----------------------
TEST_EQ("Domain.GetFloatValue() == 0.0", Instance.GetFloatValue(), 0.0);
// poke the C++ parameter default into the global
Instance.SetFloatValueOptional();
TEST_EQ("Domain.GetFloatValue() == 1.0", Instance.GetFloatValue(), 1.0);
// verify we can override it
Instance.SetFloatValueOptional(2.0);
TEST_EQ("Domain.GetFloatValue() == 2.0", Instance.GetFloatValue(), 2.0);
// Reset for the next pass, because this is static
Instance.SetFloatValueOptional(0.0);
// ----------------------
TEST_EQ("Domain.GetStringWithDefault( 'foo' ) == 'foo'", Instance.GetStringWithDefault('foo'), 'foo');
TEST_EQ("Domain.GetStringWithDefault() == 'Default echo string.'", Instance.GetStringWithDefault(), 'Default echo string.');
// ----------------------
{
    var ent_a = Instance.LibrarySpawnFakeEntity("foo");
    var ent_b = Instance.LibrarySpawnFakeEntity("bar");
    if (ent_a && ent_b) {
        ent_a.SetIntValue(5);
        ent_b.SetIntValue(6);
        TEST_EQ("ent_a.GetIntValue() == 5", ent_a.GetIntValue(), 5);
        TEST_EQ("ent_b.GetIntValue() == 6", ent_b.GetIntValue(), 6);
    }
    else {
        Instance.Log("FAILED to create entities");
    }
    if (ent_a)
        Instance.LibraryDestroyFakeEntity(ent_a);
    if (ent_b)
        Instance.LibraryDestroyFakeEntity(ent_b);
}
// ----------------------
let bGenerateIntCalled = false;
let nGeneratedInt;
Instance.GenerateInt(input => {
    bGenerateIntCalled = true;
    nGeneratedInt = input * 2;
    return nGeneratedInt;
});
Instance.PublicMethod("TestPublicMethod", (val) => {
    TEST_EQ("GenerateInt called before TestPublicMethod", bGenerateIntCalled, true);
    TEST_EQ("TestPublicMethod called with GenerateInt output", nGeneratedInt, val);
});
// ----------------------
const x = Instance.GetFloatValue;
let bDidThrow = false;
try {
    x();
}
catch (e) {
    bDidThrow = true;
}
TEST_EQ("bDidThrow", bDidThrow, true);
