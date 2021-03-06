package hxl8.responses;

import haxe.io.Bytes;
import haxe.io.BytesBuffer;

import hxl8.commands.L8CrcCalc;

import hxl8.exceptions.L8SendException;

import hxl8.responses.L8ResponseBase;

class L8ResponseVersions extends L8ResponseBase
{
    private var m_versionLightOS : String = "???";
    private var m_versionHardware : String = "???";
    private var m_versionBootloader : String = "???";
    private var m_versionData : String = "???";

    public function new ()
    {
        super ();
    }
    override public function parseData (data : Bytes) : Void
    {
        super.parseData (data);
        
        if (data.length != 10)
        {
		    m_versionLightOS = "???";
		    m_versionHardware = "???";
		    m_versionBootloader = "???";
            m_versionData = "???";
            return;
        }
        m_versionLightOS = data.get (1) + "." + zeroFill (data.get (2)) + "." + zeroFill (data.get (3));
        m_versionHardware = data.get (4) + "." + zeroFill (data.get (5));
        m_versionBootloader = data.get (6) + "." + zeroFill (data.get (7));
        m_versionData = data.get (8) + "." + zeroFill (data.get (9));
    }
    private function zeroFill (value : Int) : String
    {
        return StringTools.lpad (Std.string (value), "0", 2);
    } 
    override public function toString () : String
    {
        return 'Versions:\nLightOS: $m_versionLightOS\nHardware: $m_versionHardware\nBooloader: $m_versionBootloader\nData: $m_versionData';
    }
}