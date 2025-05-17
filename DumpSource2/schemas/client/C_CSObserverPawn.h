// MNetworkVarTypeOverride = "CCSObserver_ObserverServices m_pObserverServices"
// MNetworkIncludeByName = "m_pObserverServices"
// MNetworkVarTypeOverride = "CCSObserver_MovementServices m_pMovementServices"
// MNetworkIncludeByName = "m_pMovementServices"
// MNetworkVarTypeOverride = "CCSObserver_CameraServices m_pCameraServices"
// MNetworkIncludeByName = "m_pCameraServices"
// MNetworkVarTypeOverride = "CCSObserver_UseServices m_pUseServices"
// MNetworkIncludeByName = "m_pUseServices"
// MNetworkVarTypeOverride = "CCSObserver_ViewModelServices m_pViewModelServices"
// MNetworkIncludeByName = "m_pViewModelServices"
class C_CSObserverPawn : public C_CSPlayerPawnBase
{
	CEntityHandle m_hDetectParentChange;
};
