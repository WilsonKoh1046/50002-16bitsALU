<?xml version="1.0" encoding="UTF-8"?>
<project name="16bitsALU" board="Mojo V3" language="Lucid">
  <files>
    <src>boolean.luc</src>
    <src>alu.luc</src>
    <src>multiplier.luc</src>
    <src>shifter.luc</src>
    <src>seven_seg.luc</src>
    <src>multi_seven_seg.luc</src>
    <src>adder.luc</src>
    <src>compare.luc</src>
    <src top="true">mojo_top.luc</src>
    <ucf lib="true">mojo.ucf</ucf>
    <component>decoder.luc</component>
    <component>reset_conditioner.luc</component>
    <component>pipeline.luc</component>
    <component>button_conditioner.luc</component>
    <component>counter.luc</component>
    <component>edge_detector.luc</component>
  </files>
</project>
