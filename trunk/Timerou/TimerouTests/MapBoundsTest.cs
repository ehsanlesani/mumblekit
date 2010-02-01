using System;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Mumble.Timerou.Models;

namespace TimerouTests
{
    /// <summary>
    /// Summary description for UnitTest1
    /// </summary>
    [TestClass]
    public class MapBoundsTest
    {
        public MapBoundsTest()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        private TestContext testContextInstance;

        /// <summary>
        ///Gets or sets the test context which provides
        ///information about and functionality for the current test run.
        ///</summary>
        public TestContext TestContext
        {
            get
            {
                return testContextInstance;
            }
            set
            {
                testContextInstance = value;
            }
        }

        #region Additional test attributes
        //
        // You can use the following additional attributes as you write your tests:
        //
        // Use ClassInitialize to run code before running the first test in the class
        // [ClassInitialize()]
        // public static void MyClassInitialize(TestContext testContext) { }
        //
        // Use ClassCleanup to run code after all tests in a class have run
        // [ClassCleanup()]
        // public static void MyClassCleanup() { }
        //
        // Use TestInitialize to run code before running each test 
        // [TestInitialize()]
        // public void MyTestInitialize() { }
        //
        // Use TestCleanup to run code after each test has run
        // [TestCleanup()]
        // public void MyTestCleanup() { }
        //
        #endregion

        [TestMethod]
        public void TestValues()
        {
            var topLeft = new LatLng(10, 175);
            var bottomRight = new LatLng(40, -165);

            var bounds = new MapBounds(topLeft, bottomRight);

            TestContext.WriteLine("CrossMeridian: {0}", bounds.CrossMeridian);
            TestContext.WriteLine("Height: {0}", bounds.Height);
            TestContext.WriteLine("Width: {0}", bounds.Width);
            TestContext.WriteLine("Center: {0}", bounds.Center);
        }
    }
}
