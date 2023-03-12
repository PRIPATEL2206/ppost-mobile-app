import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ppostman/components/app_text.dart';
import 'package:ppostman/controlers/web_controler.dart';
import 'package:ppostman/get_helper/get_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic _response = "";
  String _reqType = "get";
  late WebControler _webControler;
  late TextEditingController _url;
  late TextEditingController _header;
  late TextEditingController _body;

  @override
  void initState() {
    super.initState();
    _webControler = GetHelper.get<WebControler>()!;
    _url = TextEditingController(text: "");
    _header = TextEditingController(
        text: "{ \n    \"content-type\"  :  \"text/json\"\n}");
    _body = TextEditingController(text: "");
  }

  @override
  void dispose() {
    super.dispose();
    _body.dispose();
    _url.dispose();
    _header.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isJson = false;
    try {
      _response = json.decode(_response);
      isJson = true;
    } catch (e) {
      isJson = false;
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Container(
              margin: const EdgeInsets.only(left: 3),
              clipBehavior: Clip.hardEdge,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: TextField(
                controller: _url,
                style: const TextStyle(fontSize: 20),
                onChanged: (value) => setState(() {}),
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 14),
                  hintText: "URL",
                ),
              ),
            ),
            titleSpacing: 2,
            actions: [
              Container(
                margin: const EdgeInsets.all(3),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButton(
                  dropdownColor: Colors.teal,
                  iconSize: 0,
                  borderRadius: BorderRadius.circular(10),
                  value: _reqType,
                  alignment: Alignment.center,
                  items: const [
                    DropdownMenuItem<String>(
                        value: "get",
                        child: AppText(
                          color: Colors.white,
                          text: "GET",
                        )),
                    DropdownMenuItem<String>(
                        value: "post",
                        child: AppText(
                          text: "POST",
                          color: Colors.white,
                        )),
                    DropdownMenuItem<String>(
                        value: "put",
                        child: AppText(
                          text: "PUT",
                          color: Colors.white,
                        )),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _reqType = value;
                      });
                    }
                  },
                ),
              )
            ],
            bottom: const TabBar(
                labelPadding: EdgeInsets.only(bottom: 5, top: 15),
                tabs: [
                  AppText(
                    text: "Header",
                    fontSize: 18,
                  ),
                  AppText(
                    text: "Body",
                    fontSize: 18,
                  ),
                ]),
          ),
          body: Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: TabBarView(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        hintText: "Header",
                      ),
                      style: const TextStyle(fontSize: 20),
                      controller: _header,
                      expands: true,
                      maxLines: null,
                      minLines: null,
                      enableSuggestions: true,
                      textInputAction: TextInputAction.newline,
                    ),
                    TextField(
                      controller: _body,
                      decoration: const InputDecoration(
                        hintText: "Body",
                      ),
                      style: const TextStyle(fontSize: 20),
                      expands: true,
                      maxLines: null,
                      minLines: null,
                      enableSuggestions: true,
                      textInputAction: TextInputAction.newline,
                    ),
                  ],
                ),
              ),
              DraggableScrollableSheet(
                initialChildSize: .3,
                minChildSize: .2,
                maxChildSize: .5,
                builder: (context, scrollController) {
                  return Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          height: 4,
                          width: 70,
                          color: Colors.grey,
                        ),
                        const Divider(
                          height: 0,
                          thickness: .5,
                          color: Colors.black,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (_response == null)
                                    const CircularProgressIndicator()
                                  else if (isJson)
                                    for (final key in _response.keys)
                                      if (_response[key].runtimeType == List)
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppText(
                                                text: "$key  : ",
                                                maxLine: 10,
                                                fontSize: 17,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  for (final ele
                                                      in (_response[key]
                                                          as List))
                                                    AppText(
                                                        fontSize: 17,
                                                        maxLine: 100,
                                                        text: " $ele ")
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      else
                                        AppText(
                                            fontSize: 17,
                                            maxLine: 100,
                                            text: " $key : ${_response![key]} ")
                                  else
                                    AppText(
                                      text: _response!,
                                      fontSize: 17,
                                      maxLine: 200,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          floatingActionButton: ElevatedButton(
            child: const AppText(
              text: "SEND",
            ),
            onPressed: () {
              _response = null;
              if (_reqType == "get") {
                _webControler
                    .sendGetRequest(
                      context: context,
                      _url.text,
                      header: _header.text,
                    )
                    .then((value) => setState(
                          () {
                            _response = _webControler.responseBody;
                          },
                        ));
              } else if (_reqType == "post") {
                _webControler
                    .sendPostRequest(_url.text,
                        context: context,
                        header: _header.text,
                        body: _body.text)
                    .then((value) => setState(
                          () {
                            _response = _webControler.responseBody;
                          },
                        ));
              } else if (_reqType == "put") {
                _webControler
                    .sendPutRequest(_url.text,
                        context: context,
                        header: _header.text,
                        body: _body.text)
                    .then((value) => setState(
                          () {
                            _response = _webControler.responseBody;
                          },
                        ));
              } else {
                _response = "";
              }

              setState(() {});
            },
          )),
    );
  }
}
