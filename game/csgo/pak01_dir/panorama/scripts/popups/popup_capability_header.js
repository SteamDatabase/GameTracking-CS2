'use strict';

var CapabilityHeader = ( function()
{
	var m_bShowWarning = true;                                            
	var m_strWarningText = '';                                                   
	var m_worktype = '';                                                                             
	var m_storeItemid = '';
	var m_itemid = '';                             
	var m_itemtype = '';                                       
	var m_ToolId = '';
	var m_isXrayMode = false;
	var m_allowXrayClaim = false;
	var m_allowXrayPurchase = false;
	var m_inspectOnly = false;
	
	var _Init = function( elPanel, itemId, funcGetSettingCallback )
	{
		m_itemid = itemId;
		m_worktype = funcGetSettingCallback( "asyncworktype", "" );
		m_storeItemid = funcGetSettingCallback( "storeitemid", "" );
		m_ToolId = funcGetSettingCallback( "toolid", "" );
		m_isXrayMode = ( funcGetSettingCallback( "isxraymode", "no" ) === 'yes' ) ? true : false; 
		m_allowXrayPurchase = ( funcGetSettingCallback( "allowxraypurchase", "no" ) === 'yes' ) ? true : false; 
		m_allowXrayClaim = ( funcGetSettingCallback( "allowxrayclaim", "no" ) === 'yes' ) ? true : false; 
		m_inspectOnly = ( funcGetSettingCallback( 'inspectonly', 'false' ) === 'true' ) ? true : false;

		                                                                              
		if ( !m_worktype && !m_storeItemid )
			return;

		if ( m_itemid != undefined && m_itemid != null && m_itemid !== '' )
		{
			var itemDefName = ItemInfo.GetItemDefinitionName( m_itemid );
			if ( itemDefName && itemDefName.indexOf( "spray" ) != -1 )
				m_itemtype = "_graffiti";
			else if ( itemDefName && itemDefName.indexOf( "tournament_pass_" ) != -1 )
				m_itemtype = "_fantoken";
		}
		
		m_bShowWarning = ( funcGetSettingCallback( "asyncworkitemwarning", "yes" ) === 'no' ) ? false : true;
		m_strWarningText = funcGetSettingCallback( "asyncworkitemwarningtext", '' );
		                                                                     

		elPanel.RemoveClass( 'hidden' );
		_SetDialogVariables( elPanel, itemId );
		_SetUpHeaders( elPanel );
	};
	
	var _SetDialogVariables = function( elPanel, itemId )
	{
		elPanel.SetDialogVariable( "itemname", ItemInfo.GetName( itemId ) );
	};
	
	var _SetUpHeaders = function( elPanel )
	{
		_SetUpTitle( elPanel );
		_SetUpWarning( elPanel );
		_SetUpDesc( elPanel );
	};

	var _SetUpTitle = function( elPanel )
	{
		var elTitle = elPanel.FindChildInLayoutFile( 'CapabilityTitle' );
		m_worktype = m_storeItemid ? 'purchase' : m_worktype;
		
		if ( m_inspectOnly && m_worktype === 'decodeable' )
		{
			elTitle.text = '#popup_cartpreview_title';
		}
		else if ( m_isXrayMode )
		{
			if ( m_allowXrayPurchase || m_allowXrayClaim )
			{
				elTitle.text = "#popup_xray_claim_title";
			}
			else
			{
				elTitle.text = "#popup_xray_title";
			}
		}
		                                          
		else if ( m_worktype === 'decodeable' && InventoryAPI.GetDecodeableRestriction( m_itemid ) === 'xray' )
		{
			elTitle.text = '#popup_' + m_worktype + '_xray_title';
		}
		                                                       
		else if( !m_ToolId && m_worktype === 'decodeable' )
		{
		    elTitle.text = '#popup_totool_' + m_worktype + '_header' + m_itemtype;
		}
		else
		{
			var defName = InventoryAPI.GetItemDefinitionName( m_itemid );
			if ( defName === 'casket' && m_worktype === 'nameable')
				elTitle.text = '#popup_newcasket_title';
			else
		    	elTitle.text = '#popup_' + m_worktype + '_title';
		}
	};

	var _SetUpWarning = function( elPanel )
	{
		var elWarn = elPanel.FindChildInLayoutFile( 'CapabilityWarning' );

		var sWarnLocString = '';
		if ( m_bShowWarning )
		{	                                      
			sWarnLocString = '#popup_'+m_worktype+'_warning';
			if ( m_worktype === 'decodeable' )
				sWarnLocString = sWarnLocString + m_itemtype;
		}

		if ( m_worktype === 'decodeable' )
		{
			                                                                 
			var sRestriction = m_storeItemid ? '' : InventoryAPI.GetDecodeableRestriction( m_itemid );

			if ( sRestriction === 'restricted' ||( sRestriction === 'xray' && m_isXrayMode ))
			{	                                                               
				sWarnLocString = '#popup_' + m_worktype + '_err_' + sRestriction;
				elWarn.AddClass( 'popup-capability__error' );
			}
		}

		                                          
		if ( m_strWarningText )
		{
			                                                                                  
			sWarnLocString = m_strWarningText;
		}

		elWarn.SetHasClass( 'hidden', sWarnLocString ? false : true );

		if ( sWarnLocString )
		{
			var elWarnLabel = elWarn.FindChildInLayoutFile( 'CapabilityWarningLabel' );
			elWarnLabel.text = sWarnLocString;
		}
	};

	var _SetUpDesc = function ( elPanel)
	{
		var sDescString = '';
		
		if ( m_worktype === 'decodeable'&& m_inspectOnly )
		{
			sDescString = "#popup_preview_desc";
		}
		else if ( m_isXrayMode )
		{
			if( m_allowXrayClaim || m_allowXrayPurchase )
			{
				sDescString = "#popup_xray_claim_desc";
			}
			else
			{
				sDescString = '#popup_xray_desc';
			}
		}
		else if( ( m_worktype === 'decodeable' ) && ( InventoryAPI.GetDecodeableRestriction( m_itemid ) === 'xray' ) )
		{
			sDescString = '#popup_' + m_worktype + '_xray_desc';
		}
		else
		{
			sDescString = '#popup_' + m_worktype + '_desc';

			if ( m_worktype === 'decodeable' )
			{
				sDescString = sDescString + m_itemtype;
			}
		}

	    elPanel.FindChildInLayoutFile( 'CapabilityDesc' ).text = sDescString;
	};

	return {
		Init : _Init
	};
} )();