package hxl8.responses;

import haxe.io.Bytes;
import haxe.io.BytesBuffer;

import hxl8.commands.L8CrcCalc;

import hxl8.exceptions.L8SendException;

import hxl8.responses.L8ResponseBase;

typedef AnimFrame = {
    var frame : Int;
    var delay : Int;
}

class L8ResponseReadAnim extends L8ResponseBase
{
    private var m_frames : Array<AnimFrame>;

    public function new ()
    {
        super ();
    }
    override public function parseData (data : Bytes) : Void
    {
        super.parseData (data);
        m_frames = new Array<AnimFrame> ();
        if (data.length < 4)
        {
            return;
        }
        var len : Int = data.get (1);
        for (index in 0...len)
        {
            var frame : Int = data.get (index * 2 + 2);
            var delay : Int = data.get (index * 2 + 2 + 1);
            m_frames.push ({frame : frame, delay : delay});
        }
    }
    override public function toString () : String
    {
        var buffer : StringBuf = new StringBuf ();
        var buffer2 : StringBuf = new StringBuf ();
        
        var first : Bool = true;
        for (animFrame in m_frames)
        {
            var seconds : Float = animFrame.delay / 10;
            buffer.add ('${animFrame.frame} - ${seconds}s\n');
            if (!first)
            {
                buffer2.add (",");
            }
            first = false;
            buffer2.add ('${animFrame.frame},${animFrame.delay}');
        }
        buffer.add ("\n");
        buffer.add (buffer2.toString ());
        return buffer.toString ();
    }
}