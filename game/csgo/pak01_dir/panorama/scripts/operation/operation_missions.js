
'use strict';
var OperationMissions = ( function()
{
    var m_missionsPanel = $.GetContextPanel().FindChildInLayoutFile( 'id-op-missions-panel' );
    var m_missionsList = m_missionsPanel.FindChildInLayoutFile( 'id-tiers-list' );
    var m_scheduleMissionsUpdateHandler = null;

    var _Init = function( nSeasonAccess )
    {
                                                  
		                                                                                                
                                             
    };
    
    var _MakeMissionCards = function( nSeasonAccess )
    {
        var numMissionCards = MissionsAPI.GetSeasonalOperationMissionCardsCount( nSeasonAccess );
                                                                      
        for ( var i = 0; i < numMissionCards; ++ i )
        {
            OperationMissionCard.GetMissionCardDetails( i, nSeasonAccess, m_missionsList );
        }
                                            
    };

    var _GetActiveMissonCard = function( elParent, nSeasonAccess )
    {
        if ( nSeasonAccess )
        {
            var activeCardIndx = MissionsAPI.GetSeasonalOperationMissionCardActiveIdx( nSeasonAccess );
                                                             

            if( activeCardIndx === -1 )
            {
                return null;
            }

            var jsoCardDetails = MissionsAPI.GetSeasonalOperationMissionCardDetails( nSeasonAccess, activeCardIndx );
            var elMissionCard = elParent.FindChildInLayoutFile( OperationMissionCard.MissionCardPrefix + jsoCardDetails.id );
            if ( elMissionCard )
            {
                return elMissionCard;
            }
        }
    };

    var _ScrollToMissionCard = function ( elMissionCard, elParent )
    {
        var tileHeight = elMissionCard.contentheight;
        var yPos = ( elMissionCard.actualyoffset + ( tileHeight * 1.5 ) );

        elParent.ScrollToFitRegion( 0, 0, elMissionCard.actualyoffset, elMissionCard.actualyoffset+ tileHeight, 3, true, false );
    };

    var _ReadyForDisplay = function( elPanel )
    {
                                                 
        var nSeasonAccess = parseInt( $.GetContextPanel().GetAttributeString( "season_access", "" ) );
        _UpdateMissionCardsTimer( nSeasonAccess );
        $.Schedule( 0.1, function() { m_missionsPanel.AddClass( 'show' ); });
        $.Schedule( 0.4, _SetActiveCard.bind( undefined, m_missionsList, nSeasonAccess ));

        function _SetActiveCard ( m_missionsList, nSeasonAccess)
        {
            var elActiveCard = _GetActiveMissonCard( m_missionsList, nSeasonAccess );
            if ( elActiveCard )
            {
                elActiveCard.checked = true;
                _ScrollToMissionCard( elActiveCard, m_missionsList );
            }
        }
    };

    var _UnreadyForDisplay = function( elPanel )
    {
                                                   
        m_missionsPanel.RemoveClass( 'show' );
        _CancelMissionCardsTimer();
    };

    var _UpdateMissionCardsTimer = function( nSeasonAccess )
    {
                                                    
                                                    
        m_scheduleMissionsUpdateHandler = null;

        if ( m_missionsPanel && m_missionsPanel.IsValid() && nSeasonAccess && nSeasonAccess != -1 )
        {
            _MakeMissionCards( nSeasonAccess );
            m_scheduleMissionsUpdateHandler = $.Schedule( 5.0, _UpdateMissionCardsTimer.bind( undefined, nSeasonAccess ) );
        }
    };

    var _CancelMissionCardsTimer = function()
	{
		if ( m_scheduleMissionsUpdateHandler )
		{
			$.CancelScheduled( m_scheduleMissionsUpdateHandler );
			m_scheduleMissionsUpdateHandler = null;
		}
	};

    return {
        Init: _Init,
        OnReadyForDisplay: _ReadyForDisplay,
        OnUnreadyForDisplay: _UnreadyForDisplay
    };
} )();

( function()
{
    var elMissionsPanel = $.GetContextPanel().FindChildInLayoutFile( 'id-op-missions-panel' );
    $.RegisterEventHandler( "ReadyForDisplay", elMissionsPanel, OperationMissions.OnReadyForDisplay );
	$.RegisterEventHandler( "UnreadyForDisplay", elMissionsPanel, OperationMissions.OnUnreadyForDisplay );
} )();


                                           
            
                                                                                     
                                                                  
            
               
            
                                                                        
                                                                                 
                                                                                                                
            
                                                                                                               
                                                                                 
                                                                                                       
                                                                                                 

                                                                                                                      
                                                                                                                
                                                                                                                                 
                                                                                                                               

                                             
            
                                                             
                                                                 
                                                                                             
                                                                                         
                                                                                      
                
                                                           
                                                                     
                
                                     


                                                                                      
                                                    

                                                                                   
                                                                       
                                                                                              

                                                                           
                 
               
                                       
     
                              
     
                                                                               
      
                                                                 
       

