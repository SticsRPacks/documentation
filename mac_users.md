# Tips for Mac users

The mac executable is not shipped with JavaStics anymore. Mac users have to build stics from source. Here is a tutorial to do so.

## Install JavaStics

Download the latest version of JavaStics. If you don't have an account yet, you'll have to [register first](https://w3.avignon.inra.fr/forge/account/register). Then go the this [link](https://w3.avignon.inra.fr/forge/projects/stics_main_projecv/files) and download the latest version of JavaStics, it is `JavaSTICS-1.5.1-STICS-10.0.0.zip` as the time of this writing.

Then, unzip the file and move the folder to your home directory (or any other directory you want).

## Install STICS

### Download the source code

Download the latest version of STICS from the [same link](https://w3.avignon.inra.fr/forge/projects/stics_main_projecv/files). It is `STICS-sources-v10.0.0-r3392.zip` as the time of this writing. Then, unzip the file and move the folder wherever you want.

### Compile the executable

Open a terminal in the folder where you unzipped the STICS source code. Then, run the following commands:

```bash
cd ./Debug
make all
```

This will create a `stics` executable in the `Debug` folder. 

### Move the executable

Rename the `Stics` executable into `stic_modulo_mac`, and move it to the bin folder inside the `JavaSTICS-1.5.1-STICS-10.0.0` folder. Then, you can run the `JavaSTICS-1.5.1-STICS-10.0.0` executable, and it will use this new executable by default!

## Open JavaStics

To run JavaStics, you have to execute the following command in a terminal:

```bash
java -jar JavaStics.exe 
```

And that's it! You can now use JavaStics on your mac!

## Troubleshooting

If you are running SticsRPacks' tutorial, you have to put the `stic_modulo_mac` executable in the `javastics` folder that was automatically installed.