/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, { Component } from 'react';
import {
  Platform,
  StyleSheet,
  Text,
  View,
  TouchableOpacity
} from 'react-native';
import { NativeEventEmitter, NativeModules } from 'react-native';
const { NativeModule } = NativeModules;

const nativeModuleEmiiter = new NativeEventEmitter(NativeModule);

const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n' + 'Cmd+D or shake for dev menu',
  android:
    'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu'
});

type Props = {};
export default class App extends Component<Props> {
  componentWillMount = () => {
    nativeModuleEmiiter.addListener('NativeModule', this.callFromNative);
    // nativeModuleEmiiter.removeListener('NativeModule', this.callFromNative);
  };

  callFromNative = value => {
    console.log(value);
  };

  startGetLocation = () => {
    NativeModule.startGetLocation();
  };

  stopGetLocation = () => {
    NativeModule.stopGetLocation();
  };

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>Welcome to React Native!</Text>
        <Text style={styles.instructions}>To get started, edit App.js</Text>
        <TouchableOpacity onPress={this.startGetLocation}>
          <Text style={styles.instructions}>Start</Text>
        </TouchableOpacity>
        <TouchableOpacity onPress={this.stopGetLocation}>
          <Text style={styles.instructions}>Stop</Text>
        </TouchableOpacity>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF'
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5
  }
});
