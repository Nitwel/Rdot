# Rdot (JavaScript Signals for Godot! 🥳)

<img alt="logo" src="banner.png" height="200">

## What is Rdot?

Rdot is inspired by most modern Web Frameworks that use a reactive programming model. It enables you to write GDScript with syntax similar to [Vue](https://vuejs.org/) / [Solid](https://www.solidjs.com/) / [Qwik](https://qwik.dev/) and many other Frameworks... but in Godot!

![example](example.gif)

The most common use case for Rdot is to synchronize the state of your game with the UI, although it can be used for other things as well.

## ⚠️ Disclaimer ⚠️

This should be seen as a proof of concept and **not ready for production**. While most logic was ported over, there still needs to be more testing to be done.

Logic was sourced from [proposal-signals](https://github.com/proposal-signals/proposal-signals) and translated to GDScript.
Big shoutout to everyone who contributed to the proposal or worked on the demo in said proposal. ❤️

## Usage

```gdscript
var counter = R.state(0)

var displayText = R.computed(func(_ignore):
    return "Counter: " + str(counter.value)
)

$AddButton.button_down.connect(func(): counter.value += 1)
$SubtractButton.button_down.connect(func(): counter.value -= 1)

R.effect(func(_ignore):
    $CounterLabel.text = displayText.value
)
```

See [Explanation](#Explanation) for a walkthrough of the code.
More examples can be found in the [demo](https://github.com/Nitwel/Rdot/tree/main/demo) folder.

### Stores

Stores offer the ability to quickly create many reactive states at once. They are useful for managing the state of your game.

```gdscript

var store = R.store({ # or R.state({ ... })
    "counter": 0,
    "name": "John Doe"
})

R.effect(func(_ignore):
    $CounterLabel.text = "Counter: " + str(store.counter)
)

```

The benefit of this is that you can avoid having to access the value via the `value` property.
Stores support also nested objects, allowing you to create more complex states.

`R.state` automatically creates a store when an object is passed as an argument.

### Binding

Binding is a way to synchronize the state of a reactive value with the UI. It can be used to create 1-way or 2-way bindings.

```gdscript
var number = R.state(0)
var message = R.state("Hello World")

# 1-way binding
R.bind($Label, "text", message)

# 2-way binding
R.bind($Slider, "value", number, $Slider.value_changed)
```

There is an edge-case for bindings using Stores. When binding to a store, you have to pass the store as well as the key you want to bind to.

```gdscript
var store = R.store({
    "counter": 0,
    "name": "John Doe"
})

R.bind($Label, "text", store, "name")
R.bind($Slider, "value", store, "counter", $Slider.value_changed)
```

### Explanation

`R.` (R-dot) is the namespace for all Rdot functions.

`R.state` is a function that creates a reactive state. It returns an object with a `value` property that you can read and write to.
The methods `do_get` and `do_set(value)` are also available but behave the same as `value`.
```gdscript
var counter = R.state(0)
```

`R.computed` recalculated it's value each time a reactive value in the function changes. It returns an object with a `value` property that you can read.
The first argument can be ignored but has to be there for Godot to not complain.
```gdscript
var double = R.computed(func(_ignore):
    return counter.value * 2
)
```

`R.effect` can be used to synchronize the reactive state with the UI. It its rerun each time a reactive value in the function changes.

```gdscript
R.effect(func(_ignore):
    print("Double changed: ", double.value)
)
```

## API

```gdscript
## Creates a reactive state
R.state(initialValue: Variant) -> R.RState | RdotStore

## Creates a computed state based on the returned value of the function
R.computed(func: Callable) -> R.RComputed

## Runs the function each time a reactive value in the function changes
## Returns a function to stop the effect
R.effect(func: Callable) -> Callable

## Creates a Store based off of a Dictionary
R.store(initialValue: Dictionary) -> RdotStore

## Updates the target property when the value changes
## When a watch_signal is provided, the value will be updated when the signal is emitted (2 way binding)
## Returns a function to stop the binding
R.bind(target: Object, property: String, value: R.State | R.Computed, watch_signal: Signal = null) -> Callable

## For binding to a store
R.bind(target: Object, property: String, store: RdotStore, key: String, watch_signal: Signal = null) -> Callable
```
