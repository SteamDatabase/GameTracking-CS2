function TestKeyframes()
{
    var panel = $('#csstest');
    
                                                 
    var kfs = panel.CreateCopyOfCSSKeyframes( 'slidein' );
    
                                                
    var kf = kfs.FindClosestKeyframe( 90.0 );
    kfs.SetKeyframeProperty( kf, 'x:300px;');
    
                                                               
    kf = kfs.FindClosestKeyframe( 0.0 ); 
    kf = kfs.InsertCopyOfKeyframe( 45.0, kf );
    
                                                    
    kfs.SetKeyframeProperty( kf, 'x:200px;y:200px;');
    
                                         
    panel.UpdateCurrentAnimationKeyframes( kfs );
    
                                                                                    
    panel.DeleteKeyframes( kfs );
}


( function() {

} )();