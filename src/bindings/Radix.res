module Select = {
  module Root = {
    @react.component @module("@radix-ui/react-select")
    external make: (
      ~value: option<string>,
      ~children: React.element,
      ~onValueChange: string => unit=?,
      ~onClick: unit => unit=?,
    ) => React.element = "Root"
  }

  module Trigger = {
    @react.component @module("@radix-ui/react-select")
    external make: (
      ~asChild: bool=?,
      ~children: React.element,
      ~className: string=?,
    ) => React.element = "Trigger"
  }

  module Value = {
    @react.component @module("@radix-ui/react-select")
    external make: (
      ~asChild: bool=?,
      ~placeholder: string=?,
      ~children: React.element=?,
    ) => React.element = "Value"
  }

  module Icon = {
    @react.component @module("@radix-ui/react-select")
    external make: (
      ~asChild: bool=?,
      ~children: React.element,
      ~className: string=?,
    ) => React.element = "Icon"
  }

  module Portal = {
    @react.component @module("@radix-ui/react-select")
    external make: (~asChild: bool=?, ~children: React.element) => React.element = "Portal"
  }

  module Content = {
    @react.component @module("@radix-ui/react-select")
    external make: (
      ~asChild: bool=?,
      ~children: React.element,
      ~className: string=?,
    ) => React.element = "Content"
  }

  module Viewport = {
    @react.component @module("@radix-ui/react-select")
    external make: (
      ~asChild: bool=?,
      ~children: React.element,
      ~className: string=?,
    ) => React.element = "Viewport"
  }

  module Item = {
    @react.component @module("@radix-ui/react-select")
    external make: (
      ~asChild: bool=?,
      ~children: React.element,
      ~className: string=?,
      ~value: string=?,
    ) => React.element = "Item"
  }

  module ItemText = {
    @react.component @module("@radix-ui/react-select")
    external make: (
      ~asChild: bool=?,
      ~children: React.element,
      ~className: string=?,
    ) => React.element = "ItemText"
  }

  module ItemIndicator = {
    @react.component @module("@radix-ui/react-select")
    external make: (
      ~asChild: bool=?,
      ~children: React.element,
      ~className: string=?,
    ) => React.element = "ItemIndicator"
  }

  module ScrollUpButton = {
    @react.component @module("@radix-ui/react-select")
    external make: (
      ~asChild: bool=?,
      ~children: React.element,
      ~className: string=?,
    ) => React.element = "ScrollUpButton"
  }

  module ScrollDownButton = {
    @react.component @module("@radix-ui/react-select")
    external make: (
      ~asChild: bool=?,
      ~children: React.element,
      ~className: string=?,
    ) => React.element = "ScrollDownButton"
  }
}
