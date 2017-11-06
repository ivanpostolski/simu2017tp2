package
{
	/**
	 * ...
	 * @author Omar Hesham
	 * Applied Computational Geometry - Project
	 * Carleton University
	 */
	import away3d.animators.data.Path;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;
	import away3d.cameras.HoverCamera3D;
	import away3d.core.base.Mesh;
	import away3d.core.base.Segment;
	import away3d.core.base.Vertex;
	import away3d.core.geom.Line2D;
	import away3d.events.MouseEvent3D;
	import away3d.core.clip.RectangleClipping;
	import away3d.core.math.Number3D;
	import away3d.loaders.data.GeometryData;
	import away3d.materials.*;
	import away3d.primitives.*;	
	import away3d.core.math.Quaternion;
	import flash.text.GridFitType;
	import away3d.core.base.Object3D;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	
		
	[SWF(width="600", height="300", frameRate="30", backgroundColor="#FFFFFF")]
	public class PointOnSphere extends Sprite
	{
		//view
		public var sphereView:View3D;
		public var sphereTridentView:View3D;
		public var flatView:View3D;
		private const h:Number=300;
		private const w:Number=300;
		//cameras
		public var sphereCam:HoverCamera3D;
		public var sphereTridentCam:HoverCamera3D;
		private var lastMouseX:Number;
		private var lastMouseY:Number;
		private var lastPanAngle:Number;
		private var lastTiltAngle:Number;
		private var move:Boolean = false;
		//scene
		public var flatGrid:GridPlane;
		public var dots:Array;
		public var dots3D:Array;
		public var flatLines:Array;
		public var sphereLines:Array;
		public var segmentHolder:Mesh;
		public var sphereBase:GeodesicSphere;
		//Colors
		public static var greyRed:WireframeMaterial;
		public static var greyBlue:WireframeMaterial;
		public static var greyGreen:WireframeMaterial;
		public static var greyLightWire:WireframeMaterial;
		public static var greyLightFill:ColorMaterial;
		public static var lineMaterial:WireframeMaterial;
		public static var blank:WireframeMaterial;
		// triggers
		public static var showGrid:Boolean;
		public static var showLines:Boolean;
		public static var showWire:Boolean;
		
		public var flatContainer:DisplayObjectContainer;
		public function PointOnSphere()
		{
			// Stage Scale and Alignment
			this.stage.scaleMode = StageScaleMode.NO_BORDER;
			this.stage.align = StageAlign.TOP_LEFT;		

			// Initilize color materials & arrays
			greyRed = new WireframeMaterial(0xAA0000);
			greyGreen = new WireframeMaterial(0x00AA00);
			greyBlue = new WireframeMaterial(0x0000AA);
			greyLightWire = new WireframeMaterial(0xD5D5C8);
			greyLightFill = new ColorMaterial(0xF2F2F2);
			lineMaterial = new WireframeMaterial(0xCC0000);
			blank = new WireframeMaterial( {alpha:0} );
			dots = [];
			dots3D = [];
			flatLines = [];
			sphereLines = [];
			showLines = false;
			showGrid = false;
			showWire = false;
			
			// Create Sphere Scene
			var sphereSprite = new Sprite();
			addChild(sphereSprite);
			sphereSprite.x = w;
			sphereCam = new HoverCamera3D({z:-1200,panangle:0,tiltangle:0,targetpanangle:45,targettiltangle:45,mintiltangle:-89,yfactor:1, steps:4});
			sphereView = new View3D({camera:sphereCam,x:w/2, y:h/2});
			sphereSprite.addChild(sphereView);
			sphereSprite.addChild(makeBorder(w, h));
			sphereView.clipping.minX = -w/2;
			sphereBase = new GeodesicSphere( { material:greyLightFill } );
			sphereBase.radius = 100;
			sphereBase.fractures = 12;
			sphereView.scene.addChild(sphereBase);
			var sphereBaseBG:Sphere = new Sphere( { radius:1500, segmentsW:3, segmentsH:3, material:"white", bothsides:true} );
			sphereView.scene.addChild(sphereBaseBG);
			var sphereNorthPole:Sphere = new Sphere( { radius:7, segmentsW:8, segmentsH:8, material:"orange#orange", y:100} );
			sphereView.scene.addChild(sphereNorthPole);
			var roundY:WireCircle = new WireCircle( { radius:101.3, sides:50  } ); roundY.material = greyGreen;
			var roundZ:WireCircle = new WireCircle( { radius:101.3, sides:50  } );roundZ.rotationZ = 90;roundZ.material = greyBlue;
			var roundX:WireCircle = new WireCircle( { radius:101.3, sides:50 } ); roundX.rotationX = 90; roundX.material = greyRed;
			sphereView.scene.addChild(roundX);
			sphereView.scene.addChild(roundY);
			sphereView.scene.addChild(roundZ);
			
			var sphereTridentSprite = new Sprite();
		    sphereSprite.addChild(sphereTridentSprite);
			sphereTridentSprite.x = 5;
			sphereTridentSprite.y = h - 55;
			sphereTridentCam = new HoverCamera3D({z:-300,panangle:0,tiltangle:0,targetpanangle:45,targettiltangle:45,mintiltangle:-89,yfactor:1});
			sphereTridentView = new View3D({camera:sphereTridentCam,x:25,y:25});
			sphereTridentView.clipping.minX = sphereTridentView.clipping.minY = -30;
			sphereTridentView.clipping.maxX = sphereTridentView.clipping.maxY = 30;
			sphereTridentSprite.addChild(sphereTridentView);
			sphereTridentView.scene.addChild(new Trident(22, true));
			
			
			// Create Flat Scene
			var flatSprite = new Sprite();
			addChild(flatSprite);
			flatView = new View3D( { x:w / 2, y:h / 2 } );
			flatSprite.addChild(flatView);
			flatSprite.addChild(makeBorder(w, h));
			flatView.clipping.maxX = w / 2;
			flatView.camera.position = new Number3D(0.0000001, 2600, 0);
			flatView.camera.lookAt(new Number3D(0, 0, 0));
			var flatBase = new RegularPolygon( { radius:(Math.PI * 100), sides:40, y: -0.5 } ); flatBase.material = new ColorMaterial(0xF7F7F9);
			var flatBaseL1 = new WireCircle( { radius:(Math.PI * 50), sides:40} ); flatBaseL1.material = new WireframeMaterial(0xC0C0C0);
			var flatBaseL2 = new WireCircle( { radius:(Math.PI * 100), sides:50} ); flatBaseL2.material = new WireframeMaterial(0x808080);
			var flatTrident = new Trident(80, true); flatTrident.x = flatTrident.z = 280;
			var flatBG = new Sphere( { radius:3000, segmentsW:3, segmentsH:3, material:"white#white", bothsides:true } );
			var flatNorthPole:Sphere = new Sphere( { radius:20, segmentsW:8, segmentsH:8, material:"orange#orange"} );
			flatGrid = new GridPlane( { width:1200, height:1200, segments: 30, material:greyLightWire});
			flatView.scene.addChild(flatBase);
			flatView.scene.addChild(flatBaseL1);
			flatView.scene.addChild(flatBaseL2);
			flatView.scene.addChild(flatTrident);
			flatView.scene.addChild(flatBG);
			flatView.scene.addChild(flatNorthPole);
			flatView.scene.addChild(flatGrid);
			
			// Create Event Listeners
			addEventListener(Event.ENTER_FRAME, onEnterFrame );
			sphereSprite.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown );
			sphereSprite.addEventListener(MouseEvent.MOUSE_UP, onMouseUp );
			sphereSprite.addEventListener(MouseEvent.ROLL_OVER, onMouseEnter );
			sphereSprite.addEventListener(MouseEvent.ROLL_OUT, onMouseLeave );
			sphereSprite.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			flatBase.addEventListener(MouseEvent3D.MOUSE_DOWN, onFlatMouseDown);
			flatBG.addEventListener(MouseEvent3D.MOUSE_UP, onFlatMouseUp);
			addEventListener(MouseEvent.MOUSE_UP, onFlatMouseUp);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		public function onKeyDown(e:KeyboardEvent):void 
		{
			if (e.charCode == Keyboard.SPACE) {	showLines = !showLines; buildLines(); }
			else if(e.ctrlKey){showGrid = !showGrid; }
			else if (e.shiftKey) { showWire = !showWire; }
		}
		public function onKeyUp(e:KeyboardEvent):void 
		{
			trace(e.charCode);
		}
		public function onMouseDown(e:MouseEvent):void
		{
			lastPanAngle = sphereCam.targetpanangle;
			lastTiltAngle = sphereCam.targettiltangle;
			lastMouseX = stage.mouseX;
			lastMouseY = stage.mouseY;
			move = true;
		}
		public function onMouseUp(e:MouseEvent):void
		{
			move = false;
		}
		public function onMouseEnter(e:MouseEvent):void
		{
			move = e.buttonDown;
		}
		public function onMouseLeave(e:MouseEvent):void
		{
			move = e.buttonDown;
		}
		public function onMouseWheel(e:MouseEvent):void
		{
			// Zoom in and out in Sphere veiw
			if (sphereCam.distance<1300 && sphereCam.distance>300)
				sphereCam.distance -= 10 * e.delta;
				
			if (sphereCam.distance > 1300) sphereCam.distance = 1299;
			if (sphereCam.distance < 300) sphereCam.distance = 301;
		}
		public function onFlatMouseDown(e:MouseEvent3D):void
		{
			var flatDot:FlatDot = new FlatDot(this);
			dots.push(flatDot);
			var sphereDot:GeodesicSphere = new GeodesicSphere( { material:"orange#red" } );
			sphereDot.radius = 5; sphereDot.fractures = 2;
			dots3D.push(sphereDot);
			flatView.scene.addChild(flatDot.dotSphere);
			sphereView.scene.addChild(sphereDot);
			buildLines ();
			
		}
		public function onFlatMouseUp(e:MouseEvent):void
		{
			var i:Number;
			for each(var dot:FlatDot in dots ){
				dot.move = false;
				//dot.dotSphere.material = FlatDot.normalCol;
				
				// Double Click = delete dot
				if (dot.del) {
					i = dots.indexOf(dot);
					flatView.scene.removeChild(dot.dotSphere);
					sphereView.scene.removeChild(dots3D[i]);
					dots3D.splice(i, 1);
					dots.splice(i, 1);
					buildLines();
				}
			}
			buildLines();
		}
		private function makeBorder(w:Number,h:Number):Sprite
		{
			var border:Sprite = new Sprite();
			border.graphics.lineStyle(1,0xcccccc);
			border.graphics.drawRect(0,0,w,h);
			return border;
		}
		public function sphereUpdate():void {
			// Show Grid?
			flatGrid.material = (showGrid) ? greyLightWire: blank;
			flatGrid.y = (showGrid) ? 0 : -50;
			sphereBase.material = (showWire) ? greyLightWire: greyLightFill;
			
			var camSpeed:Number = 0.45;
			if (move) {
				sphereCam.targetpanangle = sphereTridentCam.targetpanangle = camSpeed * (stage.mouseX - lastMouseX) + lastPanAngle;
				sphereCam.targettiltangle = sphereTridentCam.targettiltangle = camSpeed * (stage.mouseY - lastMouseY) + lastTiltAngle;				
			}
			
			// The Magic Function!
			for each(var dot:FlatDot in dots) {
				var id = dots.indexOf(dot);
				if (dot.move) {	
					dots3D[id].x = Math.sin(dot.distanceSphere /100) * (dot.X / dot.distanceSphere) * 100;
					dots3D[id].y = Math.cos(dot.distanceSphere /100) * 100;
					dots3D[id].z = Math.sin(dot.distanceSphere / 100) * (dot.Z / dot.distanceSphere) * 100;
				}
				
				dots3D[id].material =  (dot.move) ? FlatDot.dragCol : FlatDot.normalCol;
			}
		}
		public function buildLines():void {
			// Delete old lines
			 for each (var line:LineSegment in flatLines) 
				flatView.scene.removeChild(line);  
			 flatLines.splice(0);
			 
			// Rebuild new 2D lines
			if(showLines){
				for (var i = 0; i < dots.length; i++ ) {
					var line = new LineSegment( { material:lineMaterial} );  // 2D
					if (i != dots.length - 1)
					{		
						line.start = new Vertex(dots[i].dotSphere.x, dots[i].dotSphere.y, dots[i].dotSphere.z);
						line.end = new Vertex(dots[i+1].dotSphere.x, dots[i+1].dotSphere.y, dots[i+1].dotSphere.z);
					}
					else {		// connect last and first nodes
						if (dots.length > 2) 
						{					
							line.start = new Vertex(dots[i].dotSphere.x, dots[i].dotSphere.y, dots[i].dotSphere.z);
							line.end = new Vertex(dots[0].dotSphere.x, dots[0].dotSphere.y, dots[0].dotSphere.z);
						}
						
					}
					flatView.scene.addChild(line);	// add to scene
					flatLines.push(line);			// add to array				
				}
			
				
				// 3D CURVES ******************
				//var num = 30; //num of segments
				//for (var m = 0; m < dots.length; m++) {	
					//var points:Array = generateInterp(dots3D[m], dots3D[m + 1], num);
					//
					// make one curve (30 tiny lines)
					//var currentCurve:ObjectContainer3D = new ObjectContainer3D();
					//for (var k = 0; k < num; k++ ) {
						//var line = new LineSegment( { material:"#red" } );
						//line.start = new Vertex(points[k].x, points[k].y, points[k].z);
						//line.end = new Vertex(points[k + 1].x, points[k + 1].y, points[k + 1].z);
						//currentCurve.addChild(line);
					//}
	//
					//sphereView.scene.addChild(currentCurve);	// add to scene
					//sphereLines.push(currentCurve);				// add to array
	//
				//}				
				// 3D CURVES END **************
			}
		}

		public function flatUpdate():void 
		{
			// Check if lines need updating
			for each (var  dot:FlatDot in dots) {
				if (dot.move) {		// if any of them is moving
					buildLines ();
					return;
				}
			}
			return;
			
			// Display 2D Distance lines - here
			// Display 3D Distance Lines - here
		}
		public function onEnterFrame(e:Event) : void
		{			
			// Refresh Flat Scene
			flatUpdate();
			flatView.render();
			
			
			// Refresh Sphere Scene
			sphereUpdate();
			sphereCam.hover();
			sphereView.render();
			sphereTridentCam.hover();
			sphereTridentView.render();
		}
	}
}