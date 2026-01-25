// MGetKV3ClassDefaults = {
//	"command": "CMD_INVALID",
//	"paramName": 0,
//	"outputSubmix": -1,
//	"inputSubmix0": -1,
//	"inputSubmix1": -1,
//	"processor": -1,
//	"inputValue0": -1,
//	"inputValue1": -1
//}
class CVMixCommand
{
	// MKV3TransferName = "command"
	VMixGraphCommandID_t m_nCommand;
	// MKV3TransferName = "paramName"
	uint32 m_nParameterNameHash;
	// MKV3TransferName = "outputSubmix"
	int32 m_nOutputSubmix;
	// MKV3TransferName = "inputSubmix0"
	int32 m_nInputSubmix0;
	// MKV3TransferName = "inputSubmix1"
	int32 m_nInputSubmix1;
	// MKV3TransferName = "processor"
	int32 m_nProcessor;
	// MKV3TransferName = "inputValue0"
	int32 m_nInputValue0;
	// MKV3TransferName = "inputValue1"
	int32 m_nInputValue1;
};
