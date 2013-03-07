BAScene
=======

Overview
--------

BAScene is a 3D scene graph library. It is unusual in its support for fully editable and persistent objects. It is written in pure Objective-C for Mac OS X 10.5 and higher. An experimental version exists with support for iOS 4.0 and higher. It has been in sporadic development since 2008.

BAScene relies on [BAFoundation](https://github.com/bgulanowski/BAFoundation), also available on Github.

Two sample projects, [Blocks](https://github.com/bgulanowski/Blocks) and [PerlinTerrain](https://github.com/bgulanowski/PerlinTerrain), demonstrate usage of BAScene. They are available as separately. The demos include compiled versions of BAScene (and BAFoundation), so it's possible to try them on their own.

The simplest way to get started with BAScene is to make your application delegate a subclass of the BAScene class. BAScene is, in turn, a subclass of the BACoreDataManager class, found in BAFoundation. BACoreDataManager combines a number of conveniences, and takes care of managing your model, persistent store coordinator, and managed object context. It offers numerous hooks to override so you can customize the behaviour.

It's not necessary to use the persistence features of BAScene. Various classes, including BASceneView, BACamera, BACameraSetup, and the various utility types and functions can be used on their own. Just add them directly to your project. The BAScene class provides some conveniences along with Core Data stack management (inherited from BACoreDataManager), but the latter can be ignored. If you never access the managed object context or other Core Data-related properties, you don't need to worry about them.

The scene graph classes are all persistent, but if you never save the object context, you don't need to worry so much about that, either. You could probably even just use an in-memory store.

The library is not designed for high-performance, although some parts have been optimized. It is primarily meant as a way to access 3D and scene graph features directly from Objective-C. It is ideally suited for use in small or medium-sized projects for creative and toy apps, demonstrations, and simple games. It is also useful for adding small amounts of 3D content to projects where 3D rendering or editing is not the primary purpose.

You can watch a [presentation](http://www.slideshare.net/bgulanowski/intro-to-bascene-framework-for-mac) about BAScene on SlideShare. As you will see in the slides, it was at one time going to be named "Scene Kit", until Apple took that name.

BAScene and SceneKit actually have very little overlap in their specific purpose and usefulness. Ensuring they are compatible is a pending task for improving BAScene.


Scene Graph Classes
-------------------

All of the proper scene graph classes represent Core Data entities. The scene graph entities provide extremely fine-grained structure to your 3D content, right down to the vertex attributes like points, texture coordinates and colours. This is to ensure that everything can be edited, and no information is lost.

### Props, Prototypes and Meshes

The "objects" in a 3D scene are each represented by a `Prop`. Props are lightweight objects which represent concrete realizations of another entity, the `Prototype`. A prototype is a collection of one or more `Mesh` objects. A mesh is a  collection of vertex data representing a rigid body. A prototype is thus a grouping of one or more rigid bodies, which can be composed to make a more complex object model. A prototype is abstract, while a prop is concrete. (I am trying to be careful not to use Object Oriented terminology. A Prop is *not* a kind of Prototype. A Prop *has a* Prototype.)


### PrototypeMeshes

In order to facilitate re-use of geometry in multiple prototypes, prototypes and peshes are related, indirectly, through the intermediate `PrototypeMesh` object. There is one `PrototypeMesh` for each use of a `Mesh` in a `Prototype`. The `PrototypeMesh` adds additional properties to the mesh that are unique to its use in that prototype: specifically `Colour`, `Transform`, and `Resource` objects. Note that this means that the same `Mesh` object can be used multiple times in one `Prototype` - each use will be facilitated by a unique  `PrototypeMesh`, so there is no conflict.


### Polygons, Points and Tuples

Meshes are built out of `Polygon` objects. In most cases, that means triangles—polygons with three coplanar vertices—but a polygon can have any number of points (instances of `Point`). A `Point` is, in turn, a collection of `Tuple` objects representing vertices, normals and texture coordinates.

To optimize performance of mesh drawing, meshes can be "compiled" (using `-[Mesh compile]`). This generates an OpenGL Vertex Buffer Object, built from the mesh's points. The VBO is then attached as a geometry `Resource` object, and from then on, that gets drawn, instead of drawing the various points using immediate mode.


### Transforms

Every `Prop` and every `PrototypeMesh` has a `Transform`: the current transformation matrix for that object, relative to its parent. For the `PrototypeMesh`, the transform is relative to the `Prototype`. For the `Prop`, the transform is relative to the world origin.


### Groups and Partitions

Returning to the `Prop` and moving in the other direction, props are collected together in groups, represented by `Group` objects. A custom kind of group is the `Partition`, designed for building octrees. Groups and partitions are not fully realized, and could use more work. In an earlier version of the library, they had a Transform of their own. I forget why I took it away. Probably I thought that the model diagram was too complicated. Maybe I should bring it back.


Drawing Classes
---------------


### BASceneView

The basics of rendering involves a view, a camera, and a collection of props. The `BASceneView` class is a subclass of `NSOpenGLView`. It provides basic support for mouse and WSAD-based keyboard control, so you can fly around your scene as though you were in a game. Use the middle mouse button to access enable X/Y plane mouse control (parallel to the screen, or left/right and up/down), and the right mouse button to enable X/Z control (parallel to the "ground", or left/right and forward/back).

`BASceneView` uses CVDisplayLink to manage drawing updates, if enabled with `-enableDisplayLink`. Otherwise, it will perform drawing in `-drawRect:`. You may manually disable display link drawing with `disableDisplayLink`. You can also configure `BASceneView` to automatically disable drawing while in a background window using the `drawInBackground` property.

`BASceneView` implements `-refresh` to update the view frustum. You can change properties on `BASceneView` to alter some aspects of the frustum, but the class will be updated to provide more control of viewing options, and support for parallel projection. (However, note that a number of OpenGL state settings for view rendering are already found on `BACamera`.)


### BACamera

`BASceneView` relies on `BACamera` for actually drawing any scene content. The view will create its own camera automatically. `BACamera` represents the viewer's point of view in the scene. It has very primitive support for animating the camera, in order to make the mouse and keyboard controls work. It also manages other aspects of OpenGL drawing state, like the background colour, back face culling, rendering mode (fill, line, point), and more. (Which settings are default is in flux, so always set all the ones that matter to you.)


### BATexture

Similar in purpose to the GLTexture class in Apple's GLKit, this provides a wrapper for OpenGL texture objects.


### Categories to support drawing

The way you actually get stuff on-screen is to provide the camera with a "draw delegate", an object which conforms to the very simple `BACameraDrawDelegate` protocol. The draw delegate should respond to two methods: `-sortedPropsForCamera:`, which returns an array of objects to be drawn (optionally sorted relative to the camera's location), and `-paintForCamera:`, which is useful for drawing overlay content (it is invoked after the scene content is drawn).

The props returned to the camera do not have to be `BAProp` objects—they can be any object which conforms to the `BAVisible` protocol, which includes only one mandatory method: `-paintForCamera:`. `BAProp` conforms to this protocol. The camera iterates over the array returned from the delegate in response to `-sortedPropsForCamera:`, asking each prop to draw itself, one by one.

Once you have a view and a camera, you can start regular drawing updates by sending `-enableDisplayLink` to `BASceneView`. Alternately, just send `-setNeedsDisplay`, and the view will be redrawn using the standard Cocoa drawing system. (Note that in the former case, drawing is performed on the display link's dedicated thread. Also, the two update techniques are mutually exclusive.)


Utility Classes
---------------


### BAScene

The `BAScene` class is a subclass of `BACoreDataManager`, a convenience for managing various aspects of Core Data which are basically boilerplate and otherwise clutter up your application delegate class. It also adds support for scheduling regular updates to your model on a dedicated dispatch queue. The simplest approach is to make your application delegate a subclass of `BAScene`, but it could also be used without subclasses as an instance variable in your delegate or your document class.



### BAVoxelArray

A subclass of `BABitArray`, this provides a simple class for storing 1-bit 3D volume data. It is primarily useful for testing and experiments. It is demonstrated in the `PerlinTerrain` project. It needs to be re-written as a subclass of `BASampleArray` to provide support for more flexible data. (`BASampleArray`, like `BABitArray`, is part of the BAFoundation framework. `BASampleArray` is an sort of Objective-C equivalent to a Vector in C++: a dynamic, variable-sized sequence of data types whose size (but not type) is specified at creation. Since using NSArray for non-objects is clumsy—even more so before the addition of literal syntax to Objective-c, and Objective-C has no support for templates—they aren't really necessary—`BASampleArray` is a workable substitute for vector-style handling of primitive and structure data types.)


Scene Updates
-------------

In order to facilitate simulation and animation, you can use the built in update queue provided by the `BAScene` class. (Remember how I suggested using it has your application delegate's superclass?) When your app starts, just send a `-startUpdates:` message, including a block that will invoke an update cycle on your model. You can pause and resume updates at will, with `-pauseUpdates` and `resumeUpdates`, or cancel updates altogether with `-cancelUpdates`, which will remove the update block and its associated timer. You must cancel the existing update timer before setting a new one (multiple invocations of of `-startUpdates:` will have no effect).


User Interface Tools
--------------------

The `BACameraSetup` class is a view controller which will create a window for changing the properties of any `BACamera` object which is assigned to its `camera` property.


Additional Features
-------------------

The project includes all its own custom types and its own basic library of mathematical routines designed to work with them. Types are declared in `BASceneTypes.h`. Routines are found in `BASceneUtilities.h`, along with useful macros and functions for random number generation, simple object drawing, and extensions to `NSColor` (which should be moved to a new file).

There are custom types for points, sizes, ranges, vectors and matrices. I have attempted to design these types to be as similar as possible to the types defined in NSGeometry.h. I have provide integer and 3D and homogeneous variants. There are some inconsistencies to the naming which still need to be addressed. Also, these types are based on OpenGL types, not Core Foundation types (which vary depending on the target architecture in ways where are not in sync with types supported by OpenGL).

There are also functions for converting types into strings and back. This is marginally useful for archiving values if you don't mind truncation. A proper category on NSValue has yet to be written.

In addition, there are a number of union types which allow for easy conversion between named structure elements and array-based elements, for easier compatibility with OpenGL functions.


Example Code
------------

For examples, please see the [Blocks](https://github.com/bgulanowski/Blocks) and [PerlinTerrain](https://github.com/bgulanowski/PerlinTerrain) demo projects.


Note on the API
---------------

The API for the persistent classes follows a pattern that I have since grown disenchanted with.

The current version relies on the existence of an "active" managed object context. You can create new objects, in most cases, using class convenience methods which insert new objects, or find existing ones, in the active context. This is set automatically when you first create the BAScene object. It can also be changed, using class methods on `NSManagedObjectContext`, defined in a custom category implemented as part of BAFoundation.

For example, to make a new mesh, you might invoke `-[BAMesh meshWithTriangles:count:]`, which accepts a `BATriangle` (a struct type defined in `BASceneTypes.h`) and an integer. This create the necessary Polygon, Point and Tuple objects.

I intend to replace this design with something slightly different that I have used elsewhere, and much prefer. (Briefly, it instead defines new instance methods on `NSManagedObjectContext` using a category. But the methods are still defined in the custom ("human") class file for each given entity, as with the current design.)
