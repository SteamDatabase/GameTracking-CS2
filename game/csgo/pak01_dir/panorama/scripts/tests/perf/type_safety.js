'use strict';

                                                                                                    
                                           
                                                                                                    
(function()
{
    var panel1 = $.FindChildInContext('#Test1');
    var panel2 = $.FindChildInContext('#Test2');

    var str = "";
    
    $('#Info').text = str + "-> One";
    str += "One = " + panel1.One() + " | ";

    $('#Info').text = str + "-> Two";
    str += "Two = " + panel2.Two() + " | ";

                                                                         
    $('#Info').text = str + "-> WatTwo";
    panel1.WatTwo = panel2.Two;
    str += "WatTwo = " + panel1.WatTwo() + " | ";

    $('#Info').text = str;
})();