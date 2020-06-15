---
title: CAD
---

## Commands

<dl>
  <dt>Qsave</dt>
  <dd>Saves drawing to current name.  If unnamed, returns the Saveas dialog.</dd>
  <dt>Save</dt>
  <dd>Saves a copy of current drawing to a new name or location. Original drawing remains current</dd>
  <dt>Saveas</dt>
  <dd>Saves a copy of current drawing to a new name or location.  New drawing cecomes current</dd>
</dl>

## Standards

### Layers

| Name            | Plot     | Color     | Linetype     | Transparancy     | Description               |
| --------------- | -------- | --------- | ------------ | ---------------- | ------------------------- |
| 0               | Yes      | 7         | Continuous   | 0                |                           |
| CHECK           | yes      | 1         | Continuous   | 0                |                           |
| DOCUMENTATION   | yes      | 7         | Continuous   | 0                | All paperwork scaned in   |
| NOPLOT-SHEET    | no       | 2         | Continuous   | 0                | footprint of sheet        |

### Linking Pages Together

Linking pages will be done by using a box pointer.  The box pointer will have
the drawing title and drawing number displayed inside of it

### Revisions

After long discussion with many people, The CAD Department have come up with
the following revision guidelines:

- All drawings will have only one revision block
    - for one page drawings, this will be include in the title block
    - for two or more page drawings, will have a revision page

### Title Block

The title block will contain a minimum of the following information

- title
- scale
- drawing number
- page number
- total number of pages
- company name
- company logo
- company address
- company city
- company state
- company zip
- prepared by and date
- reviewed by and date
- approved by and date

### Text

General

* Annotative text is good to use when size and location do not matter.  For
  instance in a leader.

Standard

* 7/64" (.109375) for page leader blocks
* 3/32" (.093750) for pipe call outs

## Frequently Asked Questions

<dl>
  <dt>How to convert a line to a lwpolyline?</dt>
  <dd>use PE command</dd>
</dl>

