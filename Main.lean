import T1 
--T1 is just default init package made with`lake init T1`, not relevant for FFI demo

@[extern "my_add"]
myAddopaque  : UInt32 → UInt32 → UInt32

def main : IO Unit := do 
  IO.println s!"Hello, {hello}!"
  IO.println (myAdd 2 4)
