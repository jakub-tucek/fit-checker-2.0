//
//  EduxParser.swift
//  fit-checker
//
//  Created by Jakub Tucek on 13/01/17.
//  Copyright © 2017 Josef Dolezal. All rights reserved.
//

import Foundation
import Kanna



/// ClassificationParser is implementation of ClassificaitonParsing protocol.
/// With help of Kanna framework and simple xpath selectors parses classification
/// page. Result is returned in ClassificationResult object.
class ClassificationParser: ClasificationParsing {

    /// Selectors main div containing all data
    let mainDivSelector = "//div[contains(@class, 'page_with_sidebar')]" +
                                "/div[contains(@class, 'level1')]"

    /// Selects table names
    let tableNameSelector = "h2"

    /// Selects tbody containing row with data
    let tableSelector = "div/table/tbody"

    /// One row in table
    let rowSelector = "tr"

    /// One col in row
    let colSelector = "td"



    /// Parses classification page - all of tables and its names and returns it.
    ///
    /// - Parameter html: html to parse
    /// - Returns: result of parsing
    func parseEdux(html: String) -> ClassificationResult {
        let result = ClassificationResult()

        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
            for node in doc.xpath(self.mainDivSelector) {

                let tables = self.parseTables(node: node)

                result.tables = tables
            }
        }


        return result
    }


    /// Parsers all table names - if empty puts empty string to array.
    ///
    /// - Parameter node: node of main div
    /// - Returns: Ordered String array of names
    private func parseTableNames(node: XMLElement) -> [String] {
        var names = [String]()

        for titleNode in node.xpath(self.tableNameSelector) {
            if let title = titleNode.text {
                names.append(title)
            } else {
                names.append("")
            }
        }

        return names
    }


    /// Parses one table by iterating over all rows and calling self#parseRow
    /// method.
    ///
    /// - Parameters:
    ///   - tableNode: tbody node
    ///   - name: name of table - empty String if has no name
    /// - Returns: parsed table
    private func parseTable(tableNode: XMLElement, name: String) -> ClassificationTable {
        var rows = [ClassificationRow]()
        for rowNode in tableNode.xpath(self.rowSelector) {
            if let row = self.parseRow(rowNode: rowNode) {
                rows.append(row)
            }
        }

        return ClassificationTable(name: name, rows: rows)
    }


    /// Parses all tables and returns them as array.
    /// First parses all names, then calls self#parseTable with proper
    /// name (based on order) and tbody part of table.
    ///
    /// - Parameter node: main div
    /// - Returns: array of table objects
    private func parseTables(node: XMLElement) -> [ClassificationTable] {
        var tableCounter = 0
        var tables = [ClassificationTable]()
        let names = self.parseTableNames(node: node)

        for tableNode in node.xpath(self.tableSelector) {

            tables.append(
                self.parseTable(
                    tableNode: tableNode,
                    name: names[tableCounter]
                )
            )

            tableCounter += 1
        }

        return tables
    }


    /// Parses one row into array (of max size of 2). If size is == 2 then
    /// ClassificationRow object is created from those values.
    ///
    /// - Parameter rowNode: row (tr) node
    /// - Returns: optional of row object | empty if row has < 2 collumns
    private func parseRow(rowNode: XMLElement) -> ClassificationRow? {
        var orderedCol = [String]()
        var limit = 0

        for colNode in rowNode.xpath(self.colSelector) {

            if (limit >= 2) {
                break
            }

            if let value = colNode.innerHTML {
                orderedCol.append(value.replacingOccurrences(of: "\n", with: ""))
            } else {
                orderedCol.append("")
            }

            limit += 1
        }

        if (limit != 2) {
            return nil
        } else {
            return ClassificationRow(name: orderedCol[0], value: orderedCol[1])
        }
    }

}
