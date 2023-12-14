'use strict';

var PopupOperationLaunchMovie = ( function()
{
	var m_version;
	var m_previousVersion;

	var _Init = function()
	{
		m_previousVersion = GameInterfaceAPI.GetSettingString( 'ui_popup_weaponupdate_version' );

		                                           
		var strGoalVersion = $.GetContextPanel().GetAttributeString( "uisettingversion", m_previousVersion );
		var strSecondVersion = '' + ( parseInt( strGoalVersion ) - 1 );
		var strMovieSuffix = '1';
		if ( m_previousVersion == strSecondVersion )
		{
			                         
			strMovieSuffix = '2';
			strSecondVersion = '' + ( parseInt( strSecondVersion ) - 1 );
		}
		m_previousVersion = strSecondVersion;
		GameInterfaceAPI.SetSettingString( 'ui_popup_weaponupdate_version', m_previousVersion );
		                                                                 

		                                                               
		if ( MyPersonaAPI.GetLauncherType() === 'perfectworld' )
		{
			strMovieSuffix += '_pw';
		}

		m_version = m_previousVersion;
		
		var btns = $.GetContextPanel().FindChildInLayoutFile( 'id-operation-launch-buttons-row-buy-Btns' );
		$.DispatchEvent('PlayMainMenuMusic', false, true );
		
		$.Schedule( 6, function(){btns.AddClass('show')} );

		var elDoNotShow = $.GetContextPanel().FindChildInLayoutFile( 'id-operation-launch-btn-do-not-show' );
		elDoNotShow.SetPanelEvent( 'onactivate', _DoNotShowAgain );

		var elRepeat = $.GetContextPanel().FindChildInLayoutFile( 'id-operation-launch-btn-repeat' );
		elRepeat.SetPanelEvent( 'onactivate', _PlayAgain );

		                          
		var strMovieFilePath = "file://{resources}/videos/op_riptide_launch_"+strMovieSuffix+".webm";
		$("#VideoTrailerPlayer").SetMovie( strMovieFilePath );
		$.Schedule( 0.0, _PlayAgain );
		                                                               
	};

	var _DoNotShowAgain = function()
	{
		if( m_version === $.GetContextPanel().GetAttributeString( "uisettingversion", m_previousVersion ) )
		{
			m_version = m_previousVersion;
		}
		else
		{
			m_version = $.GetContextPanel().GetAttributeString( "uisettingversion", m_previousVersion )
		}

		GameInterfaceAPI.SetSettingString( 'ui_popup_weaponupdate_version', m_version );
		                                   
	};

	var _PlayAgain= function()
	{
		$("#VideoTrailerPlayer").Stop();
		$("#VideoTrailerPlayer").Play();
	}

	var _ClosePopup = function()
	{
		$.DispatchEvent( 'UIPopupButtonClicked', '' );
		$.DispatchEvent('PlayMainMenuMusic', true, true );
	}


	return {
		Init: _Init,
		ClosePopup: _ClosePopup
	};

})();

(function()
{
})();
