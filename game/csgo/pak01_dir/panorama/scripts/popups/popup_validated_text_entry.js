"use strict";
	

  


                                             
	   
	                                                                  
	                                 
	                                  
	                                                
	                                          
	                                        

	                                 

	                   	
						                        
						                                                      
						                                                                                    
					 

	                 
					                                          
					 
  

  

var ValidatedTextEntry = ( function ()
{
	var m_validatorFn = null;
	var m_submitFn = null;
	var m_cancelFn = null;


	function _Init()
	{
		var text = $.GetContextPanel().GetAttributeString( "text", "" );
		$.GetContextPanel().SetDialogVariable( 'text', text );

		var initialValue = $.GetContextPanel().GetAttributeString( "initValue", "" );
		$( '#TextEntry' ).text = initialValue;

		m_validatorFn = parseInt( $.GetContextPanel().GetAttributeInt( "validateCallback", -1 ) );
		m_submitFn = parseInt( $.GetContextPanel().GetAttributeInt( "submitCallback", -1 ) );
		m_cancelFn = parseInt( $.GetContextPanel().GetAttributeInt( "cancelCallback", -1 ) );

		$( "#submit" ).enabled = false;

		$( '#TextEntry' ).SetFocus();
	}

	function _Submit()
	{
		var value = $( '#TextEntry' ).text;

		UiToolkitAPI.InvokeJSCallback( m_submitFn, value );
		_Close();
	}

	                                                                                                     
	                                                                                                   
	function _Validate ()
	{
		                                                      
		var successCallback;
		function _SuccessCallback ( bSuccess )
		{
			$( "#submit" ).enabled = bSuccess;

			UiToolkitAPI.UnregisterJSCallback( successCallback );

		}

		successCallback = UiToolkitAPI.RegisterJSCallback( _SuccessCallback );

		if ( m_validatorFn != -1 )
		{
			var valueToValidate = $( '#TextEntry' ).text;

			var elResultsPanel = $( "#validation-result" );

			                          
			elResultsPanel.RemoveAndDeleteChildren();

			UiToolkitAPI.InvokeJSCallback( m_validatorFn, valueToValidate, successCallback, elResultsPanel );
		}
	}

	function _Cancel ()
	{
		UiToolkitAPI.InvokeJSCallback( m_cancelFn );
		_Close();
	}

	function _Close ()
	{
		_UnregisterAllCallbacks();
		$.DispatchEvent( 'UIPopupButtonClicked', '' );
	}

	function _UnregisterAllCallbacks ()
	{
		if ( m_validatorFn != -1 )
			UiToolkitAPI.UnregisterJSCallback( m_validatorFn );
		
		if ( m_submitFn != -1 )
			UiToolkitAPI.UnregisterJSCallback( m_submitFn );
	}

	return {
		Init: _Init,
		Submit: _Submit,
		Close: _Close,
		Cancel: _Cancel,
		Validate: _Validate,
	};

} )();

                                                                                                    
                                            
                                                                                                    
( function ()
{
  	                                                                                                                  
} )();