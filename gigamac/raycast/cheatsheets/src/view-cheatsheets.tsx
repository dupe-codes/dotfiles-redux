import { Action, ActionPanel, List, updateCommandMetadata } from "@raycast/api";
import { readdirSync, readFileSync } from "fs";

import { load } from "js-yaml";
import { useState } from "react";

const SHEETS_DIR = `${__dirname}/assets/sheets`;

interface Keybind {
  keys: string;
  action: string;
  nonprefixed: boolean | null;
}

interface Cheatsheet {
  name: string;
  prefix: string;
  keybinds: Array<Keybind>;
}

function parseFile(file_name: string): Cheatsheet {
  return load(readFileSync(file_name, "utf8")) as Cheatsheet;
}

function getCheatsheets(): Array<Cheatsheet> {
  const file_names = readdirSync(SHEETS_DIR);
  const parsed_files = file_names.map((file) => parseFile(`${SHEETS_DIR}/${file}`));
  return parsed_files;
}

function filterKeybind(keybind: Keybind, searchText: string): boolean {
  return keybind.keys.includes(searchText) || keybind.action.includes(searchText);
}

function showSheet(sheet: Cheatsheet, searchText: string, setSearchText: (text: string) => void) {
  return (
    <List
      navigationTitle={`Cheatsheet for ${sheet.name}`}
      searchBarPlaceholder={`Search`}
      searchText={searchText}
      onSearchTextChange={setSearchText}
      isLoading={false}
    >
      {sheet.keybinds
        .filter((keybind) => filterKeybind(keybind, searchText))
        .map((keybind, idx) => {
          const keyOutput = !keybind.nonprefixed ? `${sheet.prefix} + ${keybind.keys}` : keybind.keys;
          return <List.Item key={idx} title={keyOutput} accessories={[{ text: `${keybind.action}` }]} />;
        })}
    </List>
  );
}

function selectSheet(
  sheets: Array<Cheatsheet>,
  searchText: string,
  setSearchText: (text: string) => void,
  setCurrentSheet: (sheet: Cheatsheet | null) => void,
) {
  return (
    <List
      navigationTitle={"Select a cheatsheet"}
      searchBarPlaceholder="Search"
      searchText={searchText}
      onSearchTextChange={setSearchText}
      isLoading={false}
    >
      {sheets
        .filter((item) => item.name.toLowerCase().includes(searchText.toLowerCase()))
        .map((item, index) => (
          <List.Item
            key={index}
            title={item.name}
            actions={
              <ActionPanel>
                <Action
                  title="Select"
                  onAction={() => {
                    setSearchText("");
                    return setCurrentSheet(item);
                  }}
                />
              </ActionPanel>
            }
          />
        ))}
    </List>
  );
}

export default function Command() {
  updateCommandMetadata({ subtitle: "View useful cheatsheets" });

  const sheets = getCheatsheets();
  const [searchText, setSearchText] = useState("");
  const [currentSheet, setCurrentSheet] = useState<Cheatsheet | null>(null);

  if (currentSheet != null) {
    return showSheet(currentSheet, searchText, setSearchText);
  } else {
    return selectSheet(sheets, searchText, setSearchText, setCurrentSheet);
  }
}
