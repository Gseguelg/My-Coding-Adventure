# How to write a function

They are normally writen in ~/.bashrc or ~/.bash_aliases to be used by the user on each terminal window.

### General syntax

```
my_function_name(){
    #
    # Some documentation please.
    #
    ~/call_some_script.sh arg1 agr2 
    # or maybe get the arguments as the function inputs
    ~/call_other_script.sh $1 $2
}
```

### how it's used?

`$ my_function_name a`
