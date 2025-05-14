<template>
  <div class="echarts p-6 bg-gray-50 min-h-screen">
    <el-button class="mb-4" @click="dialogVisible = true">选择文件</el-button>
    <div
      class="group mb-8 p-6 bg-white rounded-xl shadow-sm border border-gray-100"
      v-for="(item, index) in echartsData"
      :key="index"
    >
      <h2 class="name text-2xl font-bold mb-6 text-gray-800 border-b pb-3">
        {{ item.gropuName }}
      </h2>
      <div
        class="echarts-list grid gap-4 grid-cols-1"
        :class="{
          'grid-cols-1': item.list.length === 1,
          'grid-cols-2': item.list.length === 2,
          'grid-cols-3': item.list.length > 2,
        }"
      >
        <div class="item" v-for="(e, eindex) in item.list" :key="eindex">
          <div
            class="echarts-item bg-gray-50 rounded-lg shadow-md p-4 hover:shadow-lg transition-shadow duration-300"
          >
            <h3 class="text-lg font-medium mb-3 text-gray-700">
              {{ e.title }}
            </h3>
            <div class="h-[300px] sm:h-[250px] lg:h-[300px]">
              <LineChat
                :id="`e_${index}_${eindex}`"
                :data="e.data"
                :title="e.title"
              />
            </div>
          </div>
        </div>
      </div>
    </div>
    <FileDialogt v-model="dialogVisible" @setData="setEchartsData" />
  </div>
</template>

<script setup lang="ts">
import LineChat from "./components/lineChat.vue";
import FileDialogt from "./components/fileDialogt.vue";
import { ref } from "vue";
import type { EchartsData } from "./utils";

const echartsData = ref<EchartsData[]>([]);
const dialogVisible = ref(false);
const setEchartsData = (data: EchartsData[]) => {
  echartsData.value = data;
};
</script>
