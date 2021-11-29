import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:sucial_cs310_project/utils/colors.dart';
import 'package:sucial_cs310_project/utils/dimensions.dart';
import 'package:sucial_cs310_project/utils/styles.dart';

class Signup extends StatefulWidget {
  Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final _formKey = GlobalKey<FormState>();
  String mail = "";
  String uname = "";
  TextEditingController pass = TextEditingController();
  TextEditingController passagain = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: Dimen.onStartingMarginInsets,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding:const EdgeInsets.all(0.0),
                      child: Image.network('data:image/jpeg;base64,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'),
                    ),
                  ],
                ),
                SizedBox(height:16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'SIGN UP',
                      style: gettingStartedStyleBold,
                    ),
                  ],
                ),
                SizedBox(height:15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 350,
                      height: 50,
                      child: Expanded(
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: AppColors.sucialColor,
                            filled: true,
                            icon: Icon(Icons.email),
                            hintText: 'E-mail',
                            hintStyle: smallExplanation,
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                color: AppColors.activeDots,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,

                          validator: (value){
                            if (value == null) {
                              return 'E-mail field cannot be empty';
                            } else {
                              String trimmedValue = value.trim();
                              if (trimmedValue.isEmpty){
                                return 'E-mail field cannot be empty';
                              }
                              if (!EmailValidator.validate(trimmedValue)){
                                return 'Please enter a valid email';
                              }
                            }
                            return null;
                          },

                          onSaved: (value){
                            if(value != null){
                              mail = value;
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height:15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 350,
                      height: 50,
                      child: Expanded(
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: AppColors.sucialColor,
                            filled: true,
                            icon: Icon(Icons.person),
                            hintText: 'Username',
                            hintStyle: smallExplanation,
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                color: AppColors.activeDots,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.text,

                          validator: (value){
                            if (value == null){
                              return 'Username field cannot be empty';
                            } else {
                              String trimmedValue = value.trim();
                              if (trimmedValue.isEmpty){
                                return 'Username field cannot be empty';
                              }
                            }
                            return null;
                          },

                          onSaved: (value){
                            if(value != null) {
                              uname = value;
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height:15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 350,
                      height: 50,
                      child: Expanded(
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: AppColors.sucialColor,
                            filled: true,
                            icon: Icon(Icons.lock),
                            hintText: 'Password',
                            hintStyle: smallExplanation,
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                color: AppColors.activeDots,
                              ),
                            ),
                          ),
                          controller: pass,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,

                          validator: (value){
                            if (value == null ) {
                              return 'Password field cannot be empty';
                            } else {
                              String trimmedValue = value.trim();
                              if (trimmedValue.isEmpty) {
                                return 'Password field cannot be empty';
                              }
                              if (trimmedValue.length < 8){
                                return 'Password must be at least 8 characters long';
                              }
                            }
                            return null;
                          },

                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height:15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 350,
                      height: 50,
                      child: Expanded(
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: AppColors.sucialColor,
                            filled: true,
                            icon: Icon(Icons.lock),
                            hintText:'Password Again',
                            hintStyle: smallExplanation,
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                color: AppColors.activeDots,
                              ),
                            ),
                          ),
                          controller: passagain,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,

                          validator: (value){
                            if (value == null ) {
                              return 'This field cannot be empty';
                            } else {
                              String trimmedValue = value.trim();
                              if (trimmedValue.isEmpty) {
                                return 'This field cannot be empty';
                              }
                              if (pass.text != passagain.text){
                                return 'Password do not match';
                              }
                            }
                            return null;
                          },

                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height:15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      width: 150,
                      child: Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            if(_formKey.currentState!.validate()){
                              _formKey.currentState!.save();
                              Navigator.pushNamed(context, '/profile');
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              'Sign Up',
                              style: smallExplanation,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Image.network('data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxAPEBANDQ8QDQ4PDw0NDQ0ODw8NDw0PFhEWFxURExUYHCggGBolGxMTIjEhJykrMDouFyszODMsNygtLisBCgoKDg0OGRAQGC0lHh4tLjctKzErLSstKysrKy8tLSswLS0tLSstLS0tLS0tKy0rKy0tLS0tLS0tLSstLS4tLf/AABEIAOEA4QMBEQACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAAAQcCBQYEA//EAEUQAAICAQEDBwYKCAUFAAAAAAABAgMEEQUSIQYHMUFRYYETIjRxkcIUIzJCYnN0obGzFyRDUpKiwdJTcpOy0TVUZIKD/8QAGgEBAAMBAQEAAAAAAAAAAAAAAAEFBgQDAv/EADQRAQABAgMEBwcEAwEAAAAAAAABAgMEBRESITFxM0FRYYGhsRMVIjSRwdEyUuHwI0LxJP/aAAwDAQACEQMRAD8AvACQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABiwliyBlFkksggAAAAAABjIJQBMWBkEAAAAAAADAwCUpg0ZBAAAARqBCYEtAY6BKUiDVkSgAAAAEagEwDAxIfSUgiZZEoAAAABDYEagSBi0QkSCdWaJfIAAAYoJOsgS2ShCISklCQAAAAA8eZtGihb191dK6vKTjFv1J9J6W7VdydKKZl8XLtFEfHMQ0OVy/wIcIzsu0/wAOqSXtlojuoynE1cYiOc/jVyVZjYjhOvg18ucvH6sa9+t1L3j3jJbv7o83j70t/tnyTVzlYz+VRkRXb8VL3hOS3uqqPP8ACYzS310y2mHy42fY9Hc6n2XQnBfxabv3nNcyvE0b9nXlv/l7U4+xV/tpzdBjZELI79U42RfRKElOPtRw1U1UTpVGjrpqirfEvqfL6AAADGQSATqEICUoISAAAAI0AaANAGgACQAADW7a25j4cN/IsUW9dytedZY/ox/r0Hvh8Ncv1aW4/DxvYiizGtUq423y/wAq/WGP+qVcUnHSV0l3y+b4e00OGyi1b33Piny/lTXsxuV7qd0eblLLHNuc25yfTKTcpP1t8WWtNMUxpEbnBMzM6ygCNCUGgEgfbDy7KJb9Fk6pfvVycdfXp0+J53LdFyNK4iX3RXVROtM6O12FziTjpDOh5SPR5etJTXfKHQ/DT1MpsTk1MxtWZ39k/lZ2MymN1yPFYWDm1XwVtFkbYS6JReq9T7H3FDXbqt1bNUaSt6K6a41pnV6D4fQBGgDQBoA0AJASAAAAAAAAAAAAHMcsOVsMGPkqtLMqS82D4xqT+fP+iLHA5fViJ2p3Ux19vdDixeMizGzH6lTZuXZfOV105W2S6Zy019SS4Jdy4GqtWqLdOzRGkKCuuqudqqdZfA+3wlBKQAAAAAAbHYe2r8KzylEuD08pVLjXauyS7e/pObE4W3iKdK/Cex7Wb9dmrWmVv8ndu1Z1XlKnpJaK2qWm/VLsfauxmTxWFrw9ezV4T2tDh79N6nWnxhtTme4AAAAAAAAAAAAAAAAAaDlhyijg06x0lfZrGiD4pPrnL6K4eOiO3AYScTc0/wBY4uTF4mLNHfPBTl90rJSssk5zm3Kc5cXKT6WzX0UU0UxTTG6GdqqmqdZ4vmfT5SEgACAN3szknm5KUq6HCD6LLmqov1J+c/YcV7MMPa3TVrPZG/8Ah028HeucKdObcR5t8zTjbjJ9m9a/cOSc6sdVM+To913f3Q+VvN5nR+S6J/5bJJ/fFH1TnOHnjEx/eaJyy9HCYc7tXZl2JZ5HIhuT3VNJSjNOLbSaafc/YWFjEUX6dqidzju2qrVWzVxeQ9nm92xdq24d0cil+cuEov5NkOuEu458Th6L9uaKv7L1s3arVW1SurY+0q8umGRS9YzXR1wkumL70zHX7NVm5NFXGGks3abtEVUvaeT1AAAAAAAAAAAAAAAMLrYwjKc2oxhFylJ8FGKWrbJpiapiI60TMRGsqP5RbXlm5E8iWqi3u0wfzKk/NXr633s2mEw8Ye1FEcevmzOIvTduTX9OTWnS8AAAAggWXyF5JQrhDMy4Kd0kp01zWqpj0qTT+e+D7vWZvMswqrqm1bndHHv/AIXWBwURHtK43zw7v5d0mUq0SBBKFU86Pp0Ps1X5lhqMm6Cec+kKLMul8HIlsrwDq+bvbfwfI+DzfxOS1Hj0Qu6Iy8fkvw7CpzXC+1t+0jjT6O/L8R7OvYnhV6raMuvwAAAAAAAAAAAAAADjuc3afksWOPF6SyZbsvqo6OXte6vEtsosbd7bnhT69SuzK9s29iONXoqo1GqhSEgAABs+TGCsjMx6JcYys3prthBOcl4qOnicuNuzasV1xx09dz3w1G3eppn+9a75GKlqKUaBLxbV2xj4kVPJtVaeu6uMpT0/diuLPexhrl6dLcavG7eotRrXLR/pCwF13P8A+T/5O33PieyPq5PeVnv+jheW22Ks3JjdRvbiphW9+O695Sm3w/8AZF5l2HrsWtmvjqq8Zepu17VPBoTvcgA1609GuKa4NPtQ7kLx5MbT+F4lN7fnyju2dXxkeEvvT9picXZ9jeqo6urk1GHu+1txV19fNtDne4AAAAAAAAAAYyAghOiUySVSc5WZ5TOdafm0VV16fSfnt/zRXgarJ7Wzh9r90/wz2Y17V7TshyxaOGAISEgADqObVa7Qj3U3Nevgv6sq84+W8Yd2XR/n8JW3IystDDEhKleV+bK/NyJSeqhZOiC/dhXJxSXim/E2eAtRbw9ER1xr9WXxlya71U9m76NOdjnAJAAALH5qMvWGRjt/InC6K/zLdf8AsXtM5nVvSuivtjT6f9XOV1601Uu+KRajAwISJkkwzCAAAAx1AnUA0BjoH1qlIIUdynt383Ll/wCRbH+F7vum1wVOzh6I7oZbFVbV6ue9rTpeICAAAA6nm09PX1F3ulVnHy/jH3d+W9P4StvQyy/Q0QnVRG2/Ssr7Tk/myNxhuho5R6Mne6WrnPq8Z7vgAAAAHX81927mTj1Tx5+1Tg1+LKjOadbET2Sscsq0uzHbC1dTML1IGDQTEp0BqyQQAAAGKCQCWwhiQlmShQ22/Ssr7Tk/myNxhuho5R6Mpd6SvnPq8Z7PgAAbnkhsuvLyo4929uOFknuPdlqlw46HFj79Vizt0cdXThLVN27s1cHevm8we2//AFV/aUXvjEd30W3u2z3/AFe7YnJHGw7fL0u1z3ZQ8+aktHprw07jxxGY3r9GxXppyetrB27VW1Tx5ugOF1MWyJTo5fJ5BYdtk7ZO7esnOyWliS3pNt6Ld7WWdGa4immKY03dzgry6zVVNU67+98/0d4Pbf8A6q/tPr3xie76Pn3bY7/qrvlJh14+Xdj07zrqlGMXJ70tdyLlq/W2aHB3K7tmmuvjP5U+Jopt3aqKeEfhrTpeIAA6rm1X6+vqLvxiVWcT/wCbxj7u/Lem8J+y2WZZoE6kaoQyUpQQkAAAARoA0AaANAlIQpHljR5PPyo6aa27671OKlr/ADGyy+vaw1E93ozOLp2b9XNqDsc4AA6bm3/6hX9Vf+CKzN/lp5w7cu6eOUrdaMo0SCAYEpEmqF0kDIlChtr5HlcjIt6VO+6SfdvvT7tDb4anZs0U9kQyt6rauVT3y8h7vMAAdrzV0b2Tdb/h0KHjOa/sZS53Xpapp7Z9P+rLK6dbk1dkev8AxZ5ml4jQCSQSAkAAAAAAAAAAq7nTwNzJqyEvNuq8nJ/Tg/6xkv4TSZLd1tVW+yfKVHmdvS5FfbHnDiy6VoAA23JXa0cPJjk2RlOMYWQ3Yab3nLvOPG4ecRa2KZ0dGFvRZubcw7b9JWP/ANvf7av7in9yXf3x5rP3pR+2fL8tjyf5ZVZt3weuq2uW5Ke9Pc3dFpw4PvObFZbXh6NuqqJe1jHUXq9iIl0xWu4JQ43M5w8eq2yp0XuVdllTa8no3GTi2vO6OBbW8nu10xVFUb416+tXV5nRTVNOzO7k89vOVQ4tRx71LRqOrq0T04a+celOSXdY1qjzec5pRMfpnyVqvb3mk00UyQAAC0ea7BcMWd7Wjvte731wW6v5t8y+c3du9FEf6x5z/YXmWW9LU1ds+Ts0VCySSAAAAAAAAAAAAAaDlvsl5eHZGC1tq+Oq7XKPTFeuLkvE7cvxHsL0VTwndLkxtmbtqYjjCmEzYs2kJAAADqebP09fUXe6VWcfL+Mfd35b03hK3DLL8Aobbi/Wsr7Tk/myNvhuho5R6Mpe33a+c+rwnvq80gSEgH1w8Wd1kKa1rOycYQXe30vuXT4HxcuU26Jrq4Q+qKJrqimOMr32dhxoqror+RVCNce1pLTV95h7lyblc1z1tTboiimKY4Q9J8PsAAAAAAAAAAAAAAAqLl9sB4t7urX6vkSco6dFdvTKHd2rx7DVZXi/bW9ir9VPnDPY7D+zr2o4T6uXLRxAAAB1PNn6evqLvdKvOPlvGPu78t6bwlbhlV+AUNtv0rK+05P5sjb4boaOUejKXelq5z6vGe74AAACxebPYOie0LVo5Jwxk+qL4Ss8ehd2vaZ7OMXrPsKerjz7Fxl2H0/y1eH5WAUS2AAAAAAAAAAAAAAAAHk2rs6vKqnRct6E1o+2L6pRfU0z0tXarVcV0Tvh53bVN2maalL7f2JbhWum1axerqtS0jbHtXf2o2GFxVF+jap8Y7P71M5iMPVZq0nwa06ngAAOp5s/T19Rd7pV5x8t4x93flvTeErcMqvwChtt+lZX2nJ/NkbfDdDRyj0ZS90tXOfV4z3fAAA6bkXyXlm2K21OOLW/OfR5eS/Zx7u1+HT0VmYY+LFOxT+qfLv/AA7cHhJvVa1fpjzW5XBRSjFKKSSSS0SS6EkZSZmWgiIjgzCQAAAAAAAAAAAYyAhsjVKYsklkEAHi2tsunLrdN8N6L4p9EoS6pRfUz1s3q7Ne1RO95XbNN2nZqVNyl5KX4Lc9Hdj/ADb4r5K7LF819/R+BqcHmFvERpwq7PwoMTg67O/jHa58sHKkDqebP09fUXe6VecfLeMfd35b03hK2mZVfo1CdFE7b9KyvtOT+bI2+F3WaOUejJ3elr5z6vGe74QEOz5K8hrL2rsxSpo4ONT1jbb6/wByP3+rpKbG5rTb+Czvq7eqFnhcBVX8VzdHZ1rPoohXGNdcVCEUoxhFaRil1JGcqqmqZqqnWZXcRERpD6HykAAGBgQk1BozJQAAAGOoE6gGgMdCE6pSJGQQAAIa1Wj4p8Gn1gcjtzkDjXtzobxLHq9IJSpk++HV4NFphs1u2vhq+KPP6/lX38vt176d0+Titpci86hvSry8F8+h7/8ALwl9xc2c0w9zjVpPf+eCtu4C9R1ax3PXzc0zhtBRshOuXkLvNnGUJfN6meObXKa8N8MxO+Pu9Mvpmm9vjTdK2NDML5joQnVSG0cK67LylTVZa/hWSvi65T/ay6WlwNpZvW6LFG1VEbo6+5lrluqq7VsxM759W42XyAzLuN27iw7ZtWT8IRf4tHJfzezRuo+KfpDpt5ddq/Vujzd1sLkhi4bU4xd1y/bW6ScX9FdEfx7ykxOYXr+6Z0jshaWMFatb+M9st+cTrSAAhsCNQMgMWglG6DVkghIAABgEpIEtkoYhLIISAAAAAGCQSnTiNUaJbBogJSkHykJAAAABiwkZAnUlCAlKCEgAAACNAGgAGpoBIAAAAAAI0AaAAGgEgAAAAAAjQBoAAA1EgJAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH/2Q==',
                      width: 42,
                      height: 42,
                    ),
                    SizedBox(
                      width:200,
                      child: Expanded(
                        child: OutlinedButton(
                          onPressed: () {

                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical:10),
                            child: Text('Login With Facebook', style: smallExplanation,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Image.network('data:image/png;base64,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',
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(
                      width: 180,
                      child: Expanded(
                        child: OutlinedButton(
                          onPressed: () {

                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical:10),
                            child: Text(
                              'Login With Google',
                              style: smallExplanation,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

