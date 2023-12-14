'use strict';

                                                                               
                                 
                                                                      
var StreamPanel = (function () {

	var m_elSteamPanel = null;
	var m_elEmbeddedStream = null;
	var m_bAllowStream = true;
	var m_bMainMenuActive = true;
	var m_valLastKnownVolume = 60;
	var m_nVolumeSliderChangedFromScript = 0;

	var _Init = function()
	{
		m_elSteamPanel = $.GetContextPanel();
		
		                                                                     
		_CloseStream();
		                                                                
		                          
		                    
	};

	var _CloseStream = function()
	{
		m_bAllowStream = false;
		_UpdateEmbeddedStream();
	};

	var _MinimizeStream = function()
	{
		m_elSteamPanel.GetParent().SetHasClass( 'minimize_stream', true );
	};

	var _FullSizeStream = function()
	{
		m_elSteamPanel.GetParent().SetHasClass( 'minimize_stream', false );
	};


	var _CSGOHideMainMenu = function()
	{
		m_bMainMenuActive = false;
		_UpdateEmbeddedStream();
	};

	var _CSGOShowMainMenu = function()
	{
		m_bMainMenuActive = true;

		                                                                     
		_CloseStream();
		                                                                
		                        	                                                          
		                          
	};

	var _UpdateEmbeddedStream = function()
	{
		var urlStreamFeed = EmbeddedStreamAPI.GetStreamFeedSourceURL();
		                                                                                                                                                       

		var elStreamPanelFeed = m_elSteamPanel.FindChildInLayoutFile( 'StreamPanelFeed' );

		if ( !m_bAllowStream || !m_bMainMenuActive )
		{
			urlStreamFeed = '';
		}

		if ( urlStreamFeed )
		{
			if ( !elStreamPanelFeed )
			{
				                                
				elStreamPanelFeed = $.CreatePanel( 'Panel', m_elSteamPanel, 'StreamPanelFeed' );
				elStreamPanelFeed.BLoadLayoutSnippet( 'stream-panel' );
				
				                               
				var elSlider = elStreamPanelFeed.FindChildInLayoutFile( 'VolumeSlider' );
				if ( elSlider )
				{
					elSlider.min = 0;
					elSlider.max = 100;
					elSlider.increment = 1;
					++m_nVolumeSliderChangedFromScript;
					elSlider.value = EmbeddedStreamAPI.GetAudioVolume();
					elSlider.SetPanelEvent( 'onvaluechanged', StreamPanel.OnVolumeSliderValueChanged );
				}
			
				_UpdateVolumeImageFromSlider();
				var elVolumeImage = elStreamPanelFeed.FindChildInLayoutFile( 'VolumeImage' );
				if ( elVolumeImage )
				{
					elVolumeImage.SetPanelEvent( 'onactivate', StreamPanel.ToggleVolumeMute );
				}

				elStreamPanelFeed.FindChildInLayoutFile( "id-close-btn" ).SetPanelEvent( 'onactivate', _CloseStream );
				elStreamPanelFeed.FindChildInLayoutFile( "id-minimize-btn" ).SetPanelEvent( 'onactivate', _MinimizeStream );
				elStreamPanelFeed.FindChildInLayoutFile( "id-full-size-btn" ).SetPanelEvent( 'onactivate', _FullSizeStream );
			}
		}
		
		if ( !elStreamPanelFeed )
		{
			return;
		}

		                           
		m_elEmbeddedStream = elStreamPanelFeed.FindChildInLayoutFile( 'StreamHTML' );
		if ( urlStreamFeed )
		{
			m_elEmbeddedStream.SetURL( urlStreamFeed );
		}
		else
		{
			_SetClassesForVideoPlaying( false );
			m_elEmbeddedStream.SetURL( 'about:blank' );
		}
	};

	var _ToggleVolumeMute = function()
	{
		var valCurrentVolume = EmbeddedStreamAPI.GetAudioVolume();
		if ( valCurrentVolume > 0 )
		{
			m_valLastKnownVolume = valCurrentVolume;
			EmbeddedStreamAPI.SetAudioVolume( 0 );
		}
		else
		{
			if ( m_valLastKnownVolume < 15 ) m_valLastKnownVolume = 60;
			EmbeddedStreamAPI.SetAudioVolume( m_valLastKnownVolume );
		}
		_OnVolumeCodeValueChanged();
	};

	var _OnVolumeSliderValueChanged = function()
	{
		if ( m_nVolumeSliderChangedFromScript > 0 )
		{
			--m_nVolumeSliderChangedFromScript;
			return;
		}

		var elSlider = m_elSteamPanel.FindChildInLayoutFile( 'VolumeSlider' );
		if ( elSlider )
		{
			var vol = elSlider.value;
			                                           
			EmbeddedStreamAPI.SetAudioVolume( vol );
			_UpdateVolumeImageFromSlider();
		}
	};

	var _OnVolumeCodeValueChanged = function()
	{
		var elSlider = m_elSteamPanel.FindChildInLayoutFile( 'VolumeSlider' );
		if ( elSlider )
		{
			++m_nVolumeSliderChangedFromScript;
			elSlider.value = EmbeddedStreamAPI.GetAudioVolume();
			_UpdateVolumeImageFromSlider();
		}
	};

	var _UpdateVolumeImageFromSlider = function()
	{
		var elSlider = m_elSteamPanel.FindChildInLayoutFile( 'VolumeSlider' );
		var elVolumeImage = m_elSteamPanel.FindChildInLayoutFile( 'VolumeImage' );
		if ( elSlider && elVolumeImage )
		{
			elVolumeImage.SetImage( ( elSlider.value > 0 ) ? 'file://{images}/icons/ui/unmuted.svg' : 'file://{images}/icons/ui/sound_off.svg' );
		}
	}

	var _UpdateEmbeddedStreamVisibility = function()
	{
		_SetClassesForVideoPlaying( EmbeddedStreamAPI.IsVideoPlaying() );
	};

	var _HTMLJSAlert = function( objHtml, sAlertText )
	{
		if ( objHtml !== 'StreamHTML' ) return;
		EmbeddedStreamAPI.PanoramaJSAlert( m_elEmbeddedStream, sAlertText );
	};

	var _HTMLFinishRequest = function( objHtml, sUrl )
	{
		                                                                             
		if ( objHtml !== 'StreamHTML' ) return;
		EmbeddedStreamAPI.PanoramaFinishRequest( m_elEmbeddedStream, sUrl, objHtml );
	};

	var _SetClassesForVideoPlaying = function( bIsVideoPlaying )
	{
		if ( m_elSteamPanel )
		{
			if ( bIsVideoPlaying )
			{
				var elTitle = m_elSteamPanel.FindChildInLayoutFile( "Title" );
				if ( elTitle )
				{
					elTitle.text = $.Localize( '#SFUI_MajorEventVenue_StreamTitle_' + NewsAPI.GetActiveTournamentEventID() + '_' + EmbeddedStreamAPI.GetStreamEventVenueID() );
				}

				  
				                                     
				  
				                                                   
				                                                                                                                                                                          
				  
				var elNavBarWatchExternalExtraButtons = m_elSteamPanel.FindChildInLayoutFile( "NavBarWatchExternalExtraButtons" );
				var sSupportedStreamTypes = EmbeddedStreamAPI.GetStreamExternalLinkTypes();
				var sChildrenWithTypeName = "NavBarWatchExternal";
				elNavBarWatchExternalExtraButtons.Children().forEach( function( elchild ) {
					if ( elchild.id.startsWith( sChildrenWithTypeName ) )
					{
						var chrLookupTypeCharacter = elchild.id.substring( sChildrenWithTypeName.length, sChildrenWithTypeName.length + 1 );
						elchild.SetHasClass( 'hidden', sSupportedStreamTypes.indexOf( chrLookupTypeCharacter ) < 0 );
					}
				} );

			}
			else
			{
				$.DispatchEvent( 'StreamPanelClosed' );
			}

			m_elSteamPanel.SetHasClass( 'hidden', !bIsVideoPlaying );
		}
	};

	return {
		Init				: _Init,
		CSGOShowMainMenu	: _CSGOShowMainMenu,
		CSGOHideMainMenu	: _CSGOHideMainMenu,
		CloseStream: _CloseStream,
		MinimizeStream: _MinimizeStream,
		FullSizeStream: _FullSizeStream,
		ToggleVolumeMute	: _ToggleVolumeMute,
		OnVolumeCodeValueChanged : _OnVolumeCodeValueChanged,
		OnVolumeSliderValueChanged : _OnVolumeSliderValueChanged,
		HTMLJSAlert			: _HTMLJSAlert,
		HTMLFinishRequest	: _HTMLFinishRequest,
		UpdateEmbeddedStream: _UpdateEmbeddedStream,
		UpdateEmbeddedStreamVisibility : _UpdateEmbeddedStreamVisibility
	};
})();


(function () {
	StreamPanel.Init();
	$.RegisterForUnhandledEvent("PanoramaComponent_EmbeddedStream_VideoReload", StreamPanel.UpdateEmbeddedStream );
	$.RegisterForUnhandledEvent("PanoramaComponent_EmbeddedStream_VideoPlaying", StreamPanel.UpdateEmbeddedStreamVisibility );
	$.RegisterForUnhandledEvent("PanoramaComponent_EmbeddedStream_VolumeChanged", StreamPanel.OnVolumeCodeValueChanged );
	$.RegisterForUnhandledEvent("CSGOHideMainMenu", StreamPanel.CSGOHideMainMenu );
	$.RegisterForUnhandledEvent("CSGOShowMainMenu", StreamPanel.CSGOShowMainMenu );

	                                                                                 
	$.RegisterEventHandler( "HTMLJSAlert", $.GetContextPanel(), StreamPanel.HTMLJSAlert );
	$.RegisterEventHandler( "HTMLFinishRequest", $.GetContextPanel(), StreamPanel.HTMLFinishRequest );
})();