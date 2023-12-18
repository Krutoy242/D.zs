/*
	Tests for D.zs
*/

#norun

val d = D({ Fluid: { name: 'water' }, A: [{ B: 1 }, { C: 2 }], a1: true });

print('-- get() --');
print(d.get()); // {Fluid:{name:"water"}, A:[{B:1},{C:2}]}
print(d.get('Fluid.name')); // water
print(d.get('a1')); // true
print(d.get('A[1].C')); // 2
print(d.get('Q[6]', { d: 6 })); // 6
print(isNull(d.get('...'))); // true
print(isNull(d.get('A[4].C'))); // true
print(isNull(D(null).get(''))); // true

print('-- get<T>() --');
print(d.getInt('A[0].B')); // 1
print(d.getInt('Q[6]', 7)); // 7
print(d.getInt('Q[6]')); // 0
print(D(true).getBool()); // true
print(D([3, 4, 5]).getInt('1')); // 4
print(D([3, 4, 5]).getInt('6')); // 0
print(D('hello').getInt('6')); // 0
print(D('hello').getString()); // hello
print(D(true).getBool()); // true
print(D(true).getInt()); // 1
print(D([true]).getBool(0)); // true
print(D(true).getBool('A.B')); // false

print('-- check() --');
print(d.check('A.B')); // false
print(d.check(['A'])); // true
print(d.check(['A', 'Fluid'])); // true

print('-- asString() --');
print(D({}).asString()); // "{}"
print(D({ A: 1 }).asString()); // "{A: 1}"
print(D(null).asString()); // "null"

print('-- isNil() --');
print(D({}).isNil()); // false
print(D(null).isNil()); // true

print('-- known Errors --');
print(D('hello').getInt()); // non-exceptional [ERROR]: DataString hello cannot be parsed to Int, substituting 0!

/*
print("-- Stress --");
var pickaxeData = {
	StatsOriginal: {
		AttackSpeedMultiplier: 1.0 as float,
		MiningSpeed: 12.0 as float,
		FreeModifiers: 3,
		Durability: 1072,
		HarvestLevel: 4,
		Attack: 4.1 as float
	},
	Stats: {
		AttackSpeedMultiplier: 1.1 as float,
		MiningSpeed: 12.0 as float,
		FreeModifiers: 3,
		Durability: 1072,
		HarvestLevel: 4,
		Attack: 4.1 as float
	},
	Special: {
		Categories: ["aoe", "harvest", "tool"]
	},
	TinkerData: {
		Materials: ["cobalt", "cobalt", "cobalt"],
		Modifiers: []
	},
	Modifiers: [{
		identifier: "lightweight",
		color: -14122284,
		level: 1
	}, {
		identifier: "momentum",
		color: -14122284,
		level: 1
	}],
	Traits: ["lightweight", "momentum"]
} as IData;

var a as string;
for i in 0 .. 1000000 {
  // a = pickaxeData.Modifiers[1].identifier;// 259ms
  // a = pickaxeData.asString();             // 4492ms
  // a = D(pickaxeData).asString();          // 5313ms
  // a = D(pickaxeData).getString(           // 2629ms
  //   "Modifiers[1].identifier"
  // );
}
*/
