# D.zs
A [ZenScript](https://docs.blamejared.com/) wrapper for safe working with Minecraft's IData.

## Installation

Drop file [D.zs](D.zs) anywhere into your Minecraft 1.12 `scripts/` folder.


## Usage

Use global function `D(IData)` to get instance of wrapper class.

```js
var data as IData = {
  ench: [
    {lvl: 1, id: 0},
    {lvl: 3, id: 2}
  ]
};

// returns "2"
D(data).get("ench[1].id").asString();

// returns 1
D(data).getInt("ench[0].lvl");
```

# Wrapper Methods




## `get`([path as `string`], [default as `IData`]) as `IData`

Safe extracting values from stored data by string or numeric keys. All parameters can be null.

**Parameters**
* `path` *optional* - Path to required data, separated with `.` or `[]`.  
  If `path` is `null`, empty `""` or stored data is `null`, `default.d` would be returned
* `default` *optional* - An `IData` object with required path "d", example `{d:0}`

**Returns**

`IData` object or `null`.  
If no parameters provided, returns stored data.

**Examples**
```js
const d = D({ Fluid: { name: 'water' }, A: [{ B: 1 }, { C: 2 }] })

// Note: all returned values is IData
d.get() // {Fluid:{name:"water"}, A:[{B:1},{C:2}]}
d.get('...') // null
d.get('Fluid.name') // water
d.get('A[1].C') // 2
d.get('A[4].C') // null
d.get('Q[6]', { d: 6 }) // 6
```




## `get<T>`([path as `string`], [default as `<T>`]) as `<T>`

Same as `get()`, but working with typed values.

Supporting types: `bool`, `byte`, `double`, `float`, `int`, `list`, `long`, `map`, `short`, `string`.  
Types are capitalized in function name `getInt()`.

**Parameters**
* `path` *optional* - Same as in `get()`
* `default` *optional* - Same as in `get()`, but value with type `<T>`

**Returns**

Same as in `get()`, but value with type `<T>`. For numeric values returns `0` instead of `null`.

**Examples**
```js
const d = D({ Fluid: { name: 'water' }, A: [{ B: 1 }, { C: 2 }] })

d.getInt('A[0].B') + d.getInt('A[1].C') // 3
d.getInt('Q[6]', 7) // 7
d.getInt('Q[6]') // 0
D(true).getBool() // true
```




## `check`(path as `string`|`string[]`) as `bool`

Check if this path or array of paths has values.

**Parameters**
* `path` - Path to required data

**Returns**

`true` if stored data have field by provided path, or if all pathes have fields

**Examples**
```js
D({ A: { B: 1 } }).check('A.B') // true
D({ A: { B: 1 } }).check(['A']) // true
D({ A: { B: 1 } }).check(['A', 'B']) // false
```




## `asString`() as `string`

Safe `IData.asString()` call (prevents exception if stored data is null)

**Returns**

`string` or `"null"`

**Examples**
```js
D({}).asString() // "{}"
D({ A: 1 }).asString() // "{A: 1}"
D(null).asString() // "null"
```




## `isNil`() as `bool`

Checks if stored data is null.  
Equivalent to `isNull(D(data).d)`

**Examples**
```js
D({}).isNil() // false
D(null).isNil() // true
```




## `isPresent`() as `bool`

Opposite to `isNil()`. Checks if stored data is not null.  