import Lake
open System Lake DSL

--fileTargetWithDep : {i : Type} → FilePath → BuildTarget i → (i → BuildM PUnit) → optParam (BuildM BuildTrace) (pure BuildTrace.nil) → FileTarget
/-
{i : Type} is {FilePath : Type}
FilePath is `("./build/myfuns.o")`
BuildTarget FilePath is `("./myfuns.cpp")`
(FilePath → BuildM PUnit) is  `(λ srcFile => do compileO ...`
-/
/-
compileO : FilePath → FilePath → optParam (Array String) #[] → optParam FilePath { toString := "cc" } → BuildM PUnit
FilePath is `("./build/myfuns.o")`
FilePath is `srcFile`
optParam (Array String) #[] is `#["-I", (← getLeanIncludeDir).toString, "-fPIC"]`
optParam FilePath { toString := "cc" } is `"c++"`
-/

def ffIOTarget : FileTarget := 
  fileTargetWithDep ("./build/myfuns.o") ("./myfuns.cpp") (λ srcFile => do
    compileO ("./build/myfuns.o") srcFile #["-I", (← getLeanIncludeDir).toString, "-fPIC"] "c++")
--`(← getLeanIncludeDir).toString` is "/home/USERNAME/.elan/toolchains/leanprover--lean4---nightly-2022-07-29/include"

extern_lib cLib := ffIOTarget




--Below is not relevant for FFI

--script doesnt run on lakebuild. Use script to investigate variables.
--script can be ran with `lake script run logVar`
script logVar do
  IO.println __dir__ 
  IO.println defaultBuildDir
  IO.println (← getLeanIncludeDir).toString 
  IO.println (nameToStaticLib "leanffi")
  return 0



package t1   {
  --srcDir is dir where the entrypoint Main.lean is located
  srcDir := "." --entry points to ./srcDir/./Main.lean
 
}
