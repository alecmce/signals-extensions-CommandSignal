package org.robotlegs.mvcs
{
	import org.osflash.signals.Signal;
	import org.robotlegs.base.SignalCommandMap;
	import org.robotlegs.core.ISignalCommandMap;
	import org.robotlegs.core.ISignalContext;

	import flash.display.DisplayObjectContainer;

    public class SignalContext extends Context implements ISignalContext
    {
        protected var _signalCommandMap:ISignalCommandMap;

		public function SignalContext(contextView:DisplayObjectContainer = null, autoStartup:Boolean = true)
		{
			super(contextView, autoStartup);
		}
		
        public function get signalCommandMap():ISignalCommandMap
        {
            return _signalCommandMap || (_signalCommandMap = new SignalCommandMap(injector.createChild(injector.applicationDomain)));
        }

        public function set signalCommandMap(value:ISignalCommandMap):void
        {
            _signalCommandMap = value;
        }

        override protected function mapInjections():void
        {
            super.mapInjections();
            injector.mapValue(ISignalCommandMap, signalCommandMap);
        }
        
        public function dispatch(clazz:Class, ... params):Boolean
        {
        	var signal:Signal = injector.getInstance(clazz);
        	var isSignal:Boolean = signal != null;
			signal.dispatch.apply(this, params);       	
        		
        	return isSignal;
        }
    }
}
