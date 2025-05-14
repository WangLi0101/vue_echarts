<template>
  <div class="charts h-full">
    <div :id="props.id" class="w-full h-full" />
  </div>
</template>

<script setup lang="ts">
import * as echarts from "echarts";
import { onBeforeMount, onMounted, watch } from "vue";
interface Props {
  id: string;
  data: Record<string, number>;
  title: string
}
const props = defineProps<Props>();
let myChart: null | echarts.ECharts = null;
const initChart = () => {
  myChart = echarts.init(document.getElementById(props.id));
};
const setOption = () => {
  const option = {
    grid: {
      left: "3%",
      right: "4%",
      bottom: "5%",
      top: "3%",
      containLabel: true
    },
    xAxis: {
      type: "category",
      data: Object.keys(props.data),
      axisTick: {
        show: true,
        alignWithLabel: true
      },
      axisLine: {
        lineStyle: {
          color: "#CECECE"
        }
      },
      axisLabel: {
        color: "#1F2937"
      }
    },
    yAxis: {
      type: "value",
      axisLine: {
        show: true,
        lineStyle: {
          color: "#CECECE"
        }
      },
      axisLabel: {
        color: "#000"
      },
      axisTick: {
        show: false
      },
      splitLine: {
        show: true,
        lineStyle: {
          color: "#CECECE",
          type: "dashed"
        }
      },
      minInterval: 1
    },
    series: [
      {
        data: Object.values(props.data),
        type: "line",
        smooth: false,
        symbol: "circle",
        symbolSize: 6,
        lineStyle: {
          color: "#F87171",
          width: 2
        },
        itemStyle: {
          color: "#F87171",
          borderWidth: 2,
          borderColor: "#FFFFFF"
        },
        areaStyle: {
          color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
            {
              offset: 0,
              color: "rgba(255, 160, 160, 1)"
            },
            {
              offset: 1,
              color: "rgba(255, 160, 160, 0.05)"
            }
          ])
        },
        markLine: {
          silent: true,
          symbol: ['none', 'arrow'],
          lineStyle: {
            color: '#10B981',
            type: 'solid',
            width: 2
          },
          data: [
            {
              type: 'average',
              name: '平均值'
            }
          ],
          label: {
            show: true,
            position: 'insideEndTop',
            distance: 8,
            formatter: '平均值: {c}',
            color: '#10B981',
            fontSize: 12,
            backgroundColor: 'rgba(255, 255, 255, 0.8)',
            padding: [4, 8]
          }
        }
      }
    ],
    tooltip: {
      trigger: "axis",
      backgroundColor: "rgba(255, 255, 255, 0.9)",
      borderColor: "#E5E7EB",
      borderWidth: 1,
      textStyle: {
        color: "#1F2937"
      },
      formatter: (params: any) => {
        return `${params[0].name}: ${params[0].data} 人`;
      }
    }
  };
  myChart?.setOption(option);
};
watch(
  () => props.data,
  () => {
    setOption();
  },
  {
    deep: true
  }
);
onMounted(() => {
  initChart();
  setOption();
});
onBeforeMount(() => {
  myChart?.dispose();
});
</script>
