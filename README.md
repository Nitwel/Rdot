# Rdot

🥳🥳 JavaScript Signals for Godot! 🥳🥳

## What is Rdot?

Rdot is inspired by most modern Web Frameworks that use a reactive programming model. It enables you to write GDScript with syntax similar to [Vue](https://vuejs.org/) / [Solid](https://www.solidjs.com/) / (Qwik)[https://qwik.dev/] and many other Frameworks... but in Godot!

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