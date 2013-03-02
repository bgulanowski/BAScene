BAScene
=======

Mac OS X framework for rendering persistent 3D objects.


BAScene is a simple scene graph library. It is still in development, and has been for a few years now. Unlike other scene graphs, objects in the scene are persistent, thanks to Core Data.

BAScene relies on BAFoundation, also available on Github.

Additionally, two demo programs (Blocks and PerlinTerrain) are available as separate Github repos. For now, the demos include compiled versions of BAScene (and BAFoundation), so it's possible to try out the demos without having to first acquire and build the frameworks from source. This is not exactly ideal, but I personally dislike having multiple copies of the same framework sources around as submodules in multiple projects.

The simplest way to get started with BAScene is to make your application delegate a subclass of the BAScene class. BAScene is, in turn, a subclass of the BACoreDataManager class, found in BAFoundation. BACoreDataManager combines a number of conveniences, and takes care of managing your model, persistent store coordinator, and managed object context. It offers numerous hooks to override so you can customize the behaviour.

It's not necessary to use the persistence features of BAScene. You can use the non-persistence features--BASceneView, BACamera, BACameraSetup, the various utility types and functions on their own, as desired. Just grab them and put them in your project directory. You don't even need the BAScene class, although it has some useful features beyond managing the Core Data stack. If you never access the managed object context or other Core Data-related properties, you don't need to worry about them.

The scene graph classes are all persistent, but if you never save the object context, you don't need to worry so much about that, either. You could probably even just use an in-memory store. But the library is not designed for high-performance, although some parts have been optimized.


Scene Graph Management
----------------------

The scene graph entities provide extremely fine-grained structure to your 3D content, right down to the vertex attributes like points, texture coordinates and colours. This is to ensure that everything can be edited, and no information is lost.

The "objects" in a 3D scene are each represented by a `Prop`. Props are lightweight objects which represent concrete realizations of another entity, the `Prototype`. A prototype is a collection of one or more `Mesh` objects. A mesh is a  collection of vertex data representing a rigid body. A prototype is thus a grouping of one or more rigid bodies, which can be composed to make a more complex object model. A prototype is abstract, while a prop is concrete. (I am trying to be careful not to use Object Oriented terminology. A Prop is *not* a kind of Prototype. A Prop *has a* Prototype.)

In order to facilitate re-use of geometry in multiple prototypes, prototypes and peshes are related, indirectly, through the intermediate `PrototypeMesh` object. There is one `PrototypeMesh` for each use of a `Mesh` in a `Prototype`. The `PrototypeMesh` adds additional properties to the mesh that are unique to its use in that prototype: specifically `Colour`, `Transform`, and `Resource` objects. Note that this means that the same `Mesh` object can be used multiple times in one `Prototype` - each use will be facilitated by a unique  `PrototypeMesh`, so there is no conflict.

Meshes are built out of `Polygon` objects. In most cases, that means triangles, but a polygon can have any number of points (instances of `Point`). A `Point` is, in turn, a collection of `Tuple` objects representing vertices, normals and texture coordinates.

To optimize performance of mesh drawing, meshes can be "compiled" (using `-[Mesh compile]`). This generates an OpenGL Vertex Buffer Object, built from the mesh's points. The VBO is then attached as a geometry `Resource` object, and from then on, that gets drawn, instead of drawing the various points using immediate mode.

Every `Prop` and every `PrototypeMesh` has a `Transform`: the current transformation matrix for that object, relative to its parent. For the `PrototypeMesh`, the transform is relative to the `Prototype`. For the `Prop`, the transform is relative to the world origin.

Returning to the `Prop` and moving in the other direction, props are collected together in groups, represented by `Group` objects. A custom kind of group is the `Partition`, designed for building octrees. Groups and partitions are not fully realized, and could use more work. In an earlier version of the library, they had a Transform of their own. I forget why I took it away. Probably I thought that the model diagram was too complicated. Maybe I should bring it back.


Note on the API
---------------

The API for the persistent classes follows a pattern that I have since grown disenchanted with.

The current version relies on the existence of an "active" managed object context. You can create new objects, in most cases, using class convenience methods which insert new objects, or find existing ones, in the active context. This is set automatically when you first create the BAScene object. It can also be changed, using class methods on `NSManagedObjectContext`, defined in a custom category implemented as part of BAFoundation.

For example, to make a new mesh, you might invoke `-[BAMesh meshWithTriangles:count:]`, which accepts a `BATriangle` (a struct type defined in `BASceneTypes.h`) and an integer. This create the necessary Polygon, Point and Tuple objects.

I intend to replace this design with something slightly different that I have used elsewhere, and much prefer. (Briefly, it instead defines new instance methods on `NSManagedObjectContext` using a category. But this category is defined in the custom ("human") class file for the entity in question.)


BAScene Usage
-------------

[to do]
