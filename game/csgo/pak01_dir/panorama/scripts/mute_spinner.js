var MuteSpinner = (function () {

	var m_curVal;
	var m_isMuted;
	var m_hFadeOutMuteBar = undefined;

	function _ToggleMute ()
	{	
		var elSpinner = $.GetContextPanel().FindChildTraverse( 'id-mute-spinner' );

		                              
		                            
		                                           

		if ( 'xuid' in $.GetContextPanel().GetParent() )
		{
			var xuid = $.GetContextPanel().GetParent().xuid;

			GameStateAPI.ToggleMute( xuid );

			_UpdateVolumeDisplay();
			
		}
	}

	function _GetCurrentValues ()
	{
		if ( 'xuid' in $.GetContextPanel().GetParent() )
		{
			var xuid = $.GetContextPanel().GetParent().xuid;

			m_curVal = GameStateAPI.GetPlayerVoiceVolume( xuid );
			m_curVal = m_curVal.toFixed( 2 );

			m_isMuted = GameStateAPI.IsSelectedPlayerMuted( xuid );

		}
	}

	function _OnValueChanged ( panel, newval )
	{
		if ( 'xuid' in $.GetContextPanel().GetParent() )
		{
			var xuid = $.GetContextPanel().GetParent().xuid;

			newval = newval.toFixed( 2 );

			_GetCurrentValues();

			if ( m_curVal != newval )
			{
				
				GameStateAPI.SetPlayerVoiceVolume( xuid, Number( newval ) );
				_UpdateVolumeDisplay();

				                  
				var elMuteBar = $.GetContextPanel().FindChildTraverse( 'id-mute-bar' );
				if ( elMuteBar )
				{
					elMuteBar.RemoveClass( "fade" );
					elMuteBar.style.height = m_curVal * 100 + "%";
		
					if ( m_hFadeOutMuteBar != undefined )
						$.CancelScheduled( m_hFadeOutMuteBar );
					
					m_hFadeOutMuteBar = $.Schedule( 0.5, () =>
					{
						elMuteBar.AddClass( "fade" );
						m_hFadeOutMuteBar = undefined;
					} );
				}
			}
		}
	}

	function _UpdateVolumeDisplay ()
	{
		_GetCurrentValues();

		                              
		                            

		$.GetContextPanel().SetDialogVariable( 'value', (m_curVal * 100).toFixed(0) );

		var elSpinner = $.GetContextPanel().FindChildTraverse( 'id-mute-spinner' );

		var elSpinnerBar = $.GetContextPanel().FindChildTraverse( 'id-mute-bar' );
		if ( !elSpinnerBar || !elSpinnerBar.IsValid() )
			return;
		
		var elSpinnerLabel = $.GetContextPanel().FindChildTraverse( 'id-mute-value' );
		if ( !elSpinnerLabel || !elSpinnerLabel.IsValid() )
			return;
		
		var elMutedImage = $.GetContextPanel().FindChildTraverse( 'id-mute-muted-img' );
		if ( !elMutedImage || !elMutedImage.IsValid() )
			return;

		if ( m_isMuted )
		{
			elMutedImage.RemoveClass( "hidden" );
			elSpinnerLabel.AddClass( "hidden" );
			elSpinnerBar.AddClass( "hidden" );
			elSpinner.AddClass( 'muted' );
		}
		else
		{
			elMutedImage.AddClass( "hidden" );
			elSpinnerLabel.RemoveClass( "hidden" );
			elSpinnerBar.RemoveClass( "hidden" );
			elSpinner.RemoveClass( 'muted' );
		}

		elSpinner.spinlock = m_isMuted;
	}


	return {
		ToggleMute: _ToggleMute,
		OnValueChanged: _OnValueChanged,
		UpdateVolumeDisplay: _UpdateVolumeDisplay,
	}
})();


                                                                                                    
                                           
                                                                                                    
(function () {

	$.RegisterEventHandler( "SpinnerValueChanged", $.GetContextPanel(), MuteSpinner.OnValueChanged );
})();